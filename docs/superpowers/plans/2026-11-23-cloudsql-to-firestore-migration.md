# Cloud SQL → Firestore Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace Firebase Data Connect (Cloud SQL) with Firestore + Firebase Auth on the free Spark plan, migrate all existing data, and decommission Cloud SQL.

**Architecture:** Only the data layer changes. Each `*_remote_datasource.dart` is rewritten against `cloud_firestore` using a small shared helper layer (`lib/core/data/`). Repositories, blocs, entities and UI are untouched. Line items are embedded in their parent report document. Dashboard stock figures come from incrementally maintained counter documents. A one-off Node script copies Postgres → Firestore/Auth.

**Tech Stack:** Flutter/Dart, `cloud_firestore`, `firebase_auth`, `fake_cloud_firestore` + `firebase_auth_mocks` (tests), Node 18+ with `firebase-admin` and `pg` (migration), Firebase emulator + `@firebase/rules-unit-testing` (rules tests).

Spec: `docs/superpowers/specs/2026-11-23-cloudsql-to-firestore-migration-design.md` (read its "Amendments" section — it overrides the earlier sections where they differ).

## Global Constraints

- Firebase project: `prabitha-operations`; Firestore region `asia-south1`.
- Free (Spark) plan limits: 50K reads/day, 20K writes/day, 1 GiB. List queries must always be date-range scoped by the caller; never add full-collection scans except for the small master/user collections.
- Dates are stored as `yyyy-MM-dd` strings; instants as Firestore `Timestamp`. Server-side creation time is stored in a field named `timestamp` using `FieldValue.serverTimestamp()`.
- Firestore field names equal the Data Connect field names in `dataconnect/schema/schema.gql` (camelCase). Document IDs for migrated rows are the old Postgres UUIDs.
- Embedded array keys: `entries` (health reports), `lineItems` (production and packing reports), `rejectedItems` (customer rejection reports).
- Auth email: `<digits of normalized phone>@prabitha.app` (normalize: keep leading `+`; 10 digits → prefix `+91`). Auth password: `prb#` + user-typed password. Legacy `uid` (the phone) stays the app-level user identity (`AppUser.uid`).
- Passwords must never be written to Firestore.
- Do not change entities, repositories, blocs or UI.
- `flutter` commands write into the Flutter SDK cache, so run them with sandbox permission `all` (or full access) or they fail with "Operation not permitted".
- Between Task 6 and Task 11 `flutter analyze` over the whole project will fail (the DI file still references the old connector). Run only the targeted test files named in each task until Task 11.
- Work on branch `feat/firestore-migration`. Commit after every task.

## Manual prerequisites (user, one time, before Task 12 and the cutover)

1. Firebase console → Build → Firestore Database → Create database → **(default)**, production mode, location **asia-south1** (cannot be changed later; confirm the location is allowed on Spark).
2. Firebase console → Build → Authentication → Sign-in method → enable **Email/Password**.
3. For the migration script: `gcloud auth application-default login` with an account that is Owner/Editor on `prabitha-operations`.
4. Access to the old database: either Cloud SQL Auth Proxy to the Data Connect instance (set a password for the `postgres` user in Cloud console → SQL first), or restore `tools/sql/backup/2026-09-28/entire_sql_backup.sql` into a local Postgres for rehearsal.

## File Structure

Create:
- `lib/core/data/firestore_support.dart` — `dateKey`, `parseDateKey`, timestamp helpers, `DocRow` typed reader, `Reports` (list/add/delete/get helpers).
- `lib/core/data/collections.dart` — collection name constants (`Col`).
- `lib/core/data/stock_ledger.dart` — `StockLine`, `StockData`, `StockLedger` (apply/read).
- `lib/features/auth/data/auth_identity.dart` — phone normalisation, Auth email/password derivation.
- `lib/features/admin/data/datasources/user_account_creator.dart` — creates Auth accounts via a secondary `FirebaseApp`.
- `firestore.rules`, `firestore.indexes.json`, `tools/gen_indexes.js`.
- `tools/firestore-rules-test/{package.json,rules.test.js}`.
- `tools/migrate/{package.json,config.js,transform.js,schema.js,stock.js,index.js,test/*.test.js,README.md}`.
- Tests: `test/core/data/*.test.dart`, `test/features/auth/auth_remote_datasource_test.dart`, `test/features/admin/admin_remote_datasource_test.dart`, `test/features/frames/frame_remote_datasource_test.dart`, `test/features/sheets/sheet_remote_datasource_test.dart`, `test/features/scrap_regrind/scrap_remote_datasource_test.dart`, `test/features/salary/salary_remote_datasource_test.dart`, `test/features/dashboard/dashboard_remote_datasource_test.dart`.

Rewrite (same public API, new internals): the seven datasources under `lib/features/*/data/datasources/`, `lib/core/utils/master_table_seeder.dart`.

Modify: `pubspec.yaml`, `firebase.json`, `lib/main.dart`, `lib/core/di/injection.dart`, `lib/features/admin/presentation/pages/admin_panel_page.dart`.

Delete (Task 13): `dataconnect/`, `lib/generated/dataconnect/`, `lib/core/utils/seed_data.dart`, `tools/seed_database.dart`, `tools/migrate_master_tables.dart`, `tools/insert_staff_users.exp`, `test/integration/seed_database_test.dart`, `test/integration/migrate_master_tables_test.dart`, `integration_test/migrate_master_tables_test.dart`.

---

### Task 1: Branch, dependencies, Firebase config

**Files:**
- Modify: `pubspec.yaml`, `firebase.json`
- Create: `firestore.rules` (placeholder deny-all, replaced in Task 3), `firestore.indexes.json` (`{"indexes":[],"fieldOverrides":[]}`)

**Interfaces:**
- Produces: `cloud_firestore`, `fake_cloud_firestore` available to later tasks.

- [ ] **Step 1: Create the branch**

```bash
cd /Users/gnaga/factory_app
git checkout -b feat/firestore-migration
```

- [ ] **Step 2: Add dependencies**

```bash
flutter pub add cloud_firestore
flutter pub add --dev fake_cloud_firestore
```
Expected: `Changed N dependencies!` with no resolution error. If `fake_cloud_firestore` conflicts with `cloud_firestore`, run `flutter pub add --dev fake_cloud_firestore:<version>` choosing the newest release that depends on the same `cloud_firestore` major (check the "Dependencies" section on pub.dev).

- [ ] **Step 3: Create placeholder rules/indexes files**

`firestore.rules`:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```
`firestore.indexes.json`:
```json
{ "indexes": [], "fieldOverrides": [] }
```

- [ ] **Step 4: Register Firestore in `firebase.json`**

Add a top-level `"firestore"` key next to the existing `"dataconnect"` key (keep `dataconnect` until Task 13):
```json
"firestore": { "rules": "firestore.rules", "indexes": "firestore.indexes.json" }
```
Validate: `python3 -c "import json;json.load(open('firebase.json'))"` → no output.

- [ ] **Step 5: Verify the project still resolves**

Run: `flutter pub get`
Expected: `Got dependencies!`

- [ ] **Step 6: Commit**

```bash
git add pubspec.yaml pubspec.lock firebase.json firestore.rules firestore.indexes.json docs/superpowers
git commit -m "chore: add cloud_firestore and firestore config for migration"
```

---

### Task 2: Core Firestore support layer

**Files:**
- Create: `lib/core/data/firestore_support.dart`, `lib/core/data/collections.dart`, `lib/core/data/stock_ledger.dart`
- Test: `test/core/data/firestore_support_test.dart`, `test/core/data/stock_ledger_test.dart`

**Interfaces:**
- Produces (used by every datasource task):
  - `String dateKey(DateTime d)`; `DateTime parseDateKey(Object? v)`; `Timestamp? toTimestamp(DateTime? d)`; `DateTime? fromTimestamp(Object? v)`
  - `class DocRow { final String id; final Map<String,dynamic> data; String str(String k,[String fallback='']); String? strOrNull(String k); int integer(String k); double real(String k); double? realOrNull(String k); bool flag(String k,{bool fallback=true}); DateTime date(String k); DateTime? timestamp(String k); List<String> strings(String k); List<DocRow> children(String k); factory DocRow.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> s); }`
  - `class Reports { Reports(FirebaseFirestore db); Future<List<DocRow>> list(String collection,{String? equalsField,String? equalsValue,String dateField='date',DateTime? startDate,DateTime? endDate}); Future<DocRow?> findOne(String collection, Map<String,Object> equals); Future<String> add(String collection, Map<String,dynamic> data); Map<String,dynamic> stamp(Map<String,dynamic> data); Future<void> delete(String collection,String id); }`
  - `abstract class StockKind { static const frame='frame'; static const sheet='sheet'; }`
  - `class StockLine { const StockLine({required String variant, required String density, required String color, int produced=0, int packed=0, int rejected=0, double packedAmount=0, double rejectedAmount=0}); }`
  - `class StockData { final double totalProduced,totalPacked,totalRejected; final List<StockLine> variants; }`
  - `class StockLedger { static String variantDocId(String kind, StockLine l); static void apply(WriteBatch batch, FirebaseFirestore db,{required String kind,required List<StockLine> lines,double producedAmount=0,int sign=1}); static Future<StockData> read(FirebaseFirestore db,String kind); }`
  - `class Col` with the constants in Step 3.

- [ ] **Step 1: Write the failing tests**

`test/core/data/firestore_support_test.dart`:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_app/core/data/firestore_support.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dateKey pads and parseDateKey round-trips to local midnight', () {
    expect(dateKey(DateTime(2026, 3, 5, 18, 30)), '2026-03-05');
    expect(parseDateKey('2026-03-05'), DateTime(2026, 3, 5));
  });

  test('DocRow typed getters with fallbacks', () {
    final row = DocRow('a1', {
      'name': 'x',
      'qty': 3,
      'w': 2,
      'on': false,
      'date': '2026-01-02',
      'at': Timestamp.fromDate(DateTime(2026, 1, 2, 3)),
      'tags': ['p', 'q'],
      'kids': [
        {'k': 1},
      ],
    });
    expect(row.str('name'), 'x');
    expect(row.str('missing'), '');
    expect(row.strOrNull('missing'), isNull);
    expect(row.integer('qty'), 3);
    expect(row.real('w'), 2.0);
    expect(row.realOrNull('missing'), isNull);
    expect(row.flag('on'), isFalse);
    expect(row.flag('missing'), isTrue);
    expect(row.date('date'), DateTime(2026, 1, 2));
    expect(row.timestamp('at'), DateTime(2026, 1, 2, 3));
    expect(row.strings('tags'), ['p', 'q']);
    expect(row.children('kids').single.integer('k'), 1);
  });

  group('Reports', () {
    late FakeFirebaseFirestore db;
    late Reports reports;
    setUp(() async {
      db = FakeFirebaseFirestore();
      reports = Reports(db);
      for (final e in [
        ('M1', '2026-11-01'),
        ('M1', '2026-11-10'),
        ('M2', '2026-11-10'),
      ]) {
        await reports.add('things', {'machineNumber': e.$1, 'date': e.$2});
      }
    });

    test('list filters by machine and inclusive date range, newest first', () async {
      final all = await reports.list('things');
      expect(all, hasLength(3));
      expect(all.first.str('date'), '2026-11-10');

      final m1 = await reports.list(
        'things',
        equalsField: 'machineNumber',
        equalsValue: 'M1',
        startDate: DateTime(2026, 11, 10),
        endDate: DateTime(2026, 11, 10, 23, 59, 59),
      );
      expect(m1.single.str('machineNumber'), 'M1');
      expect(m1.single.id, isNotEmpty);
    });

    test('add stamps a server timestamp; findOne and delete work', () async {
      final id = await reports.add('things', {'machineNumber': 'M3', 'date': '2026-12-01'});
      final found = await reports.findOne('things', {'machineNumber': 'M3', 'date': '2026-12-01'});
      expect(found!.id, id);
      expect(found.data.containsKey('timestamp'), isTrue);
      await reports.delete('things', id);
      expect(await reports.findOne('things', {'machineNumber': 'M3'}), isNull);
    });
  });
}
```

`test/core/data/stock_ledger_test.dart`:
```dart
import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('apply increments counters and reversing returns to zero', () async {
    final db = FakeFirebaseFirestore();
    const line = StockLine(variant: '3x2', density: '0.8', color: 'White', produced: 10);
    final b1 = db.batch();
    StockLedger.apply(b1, db, kind: StockKind.frame, lines: [line], producedAmount: 50);
    const pack = StockLine(
      variant: '3x2', density: '0.8', color: 'White',
      packed: 6, rejected: 1, packedAmount: 12, rejectedAmount: 2,
    );
    StockLedger.apply(b1, db, kind: StockKind.frame, lines: [pack]);
    await b1.commit();

    var data = await StockLedger.read(db, StockKind.frame);
    expect(data.totalProduced, 50);
    expect(data.totalPacked, 12);
    expect(data.totalRejected, 2);
    final v = data.variants.single;
    expect([v.variant, v.density, v.color, v.produced, v.packed, v.rejected],
        ['3x2', '0.8', 'White', 10, 6, 1]);

    final b2 = db.batch();
    StockLedger.apply(b2, db, kind: StockKind.frame, lines: [line], producedAmount: 50, sign: -1);
    await b2.commit();
    data = await StockLedger.read(db, StockKind.frame);
    expect(data.totalProduced, 0);
    expect(data.variants.single.produced, 0);
  });

  test('variantDocId slugs non-alphanumerics', () {
    const l = StockLine(variant: '3x2 "A"', density: '0.8', color: 'Off White');
    // slug('3x2 "A"') == '3x2_A_', slug('0.8') == '0_8', slug('Off White') == 'Off_White'
    expect(StockLedger.variantDocId('frame', l), 'frame__3x2_A___0_8__Off_White');
  });

  test('kinds are isolated', () async {
    final db = FakeFirebaseFirestore();
    final b = db.batch();
    StockLedger.apply(b, db, kind: StockKind.sheet,
        lines: [const StockLine(variant: '9mm', density: 'D', color: 'C', produced: 4)], producedAmount: 8);
    await b.commit();
    expect((await StockLedger.read(db, StockKind.frame)).variants, isEmpty);
    expect((await StockLedger.read(db, StockKind.sheet)).totalProduced, 8);
  });
}
```
- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/core/data`
Expected: FAIL — `Target of URI doesn't exist: 'package:factory_app/core/data/firestore_support.dart'`.

- [ ] **Step 3: Implement**

`lib/core/data/collections.dart`:
```dart
/// Firestore collection names. One per former Data Connect table.
class Col {
  Col._();

  static const users = 'users';

  // Masters
  static const masterMachines = 'master_machines';
  static const masterShifts = 'master_shifts';
  static const masterRoles = 'master_roles';
  static const masterFrameSections = 'master_frame_sections';
  static const masterFrameDensities = 'master_frame_densities';
  static const masterFrameColors = 'master_frame_colors';
  static const masterSheetThicknesses = 'master_sheet_thicknesses';
  static const masterSheetDensities = 'master_sheet_densities';
  static const masterSheetColors = 'master_sheet_colors';
  static const masterMaintenanceItems = 'master_maintenance_items';
  static const masterScrapProducts = 'master_scrap_products';
  static const masterFrameWeights = 'master_frame_weights';
  static const masterSheetWeights = 'master_sheet_weights';
  static const masterFrameTargets = 'master_frame_targets';
  static const masterSheetTargets = 'master_sheet_targets';
  static const masterSalaryWeightages = 'master_salary_weightages';
  static const masterScrapTargets = 'master_scrap_targets';

  // Frames
  static const frameCleaning = 'frame_cleaning_reports';
  static const frameToolsCount = 'frame_tools_count_reports';
  static const frameHealth = 'frame_health_reports';
  static const frameProductionDetails = 'frame_production_details_reports';
  static const frameProductionWeight = 'frame_production_weight_reports';
  static const frameShiftPacking = 'frame_shift_packing_reports';
  static const frameWritingEfficiency = 'frame_writing_efficiencies';
  static const frameCustomerRejection = 'frame_customer_rejection_reports';

  // Sheets
  static const sheetCleaning = 'sheet_cleaning_reports';
  static const sheetToolsCount = 'sheet_tools_count_reports';
  static const sheetHealth = 'sheet_health_reports';
  static const sheetProductionDetails = 'sheet_production_details_reports';
  static const sheetRunningFeet = 'sheet_running_feet_reports';
  static const sheetShiftPacking = 'sheet_shift_packing_reports';
  static const sheetWritingEfficiency = 'sheet_writing_efficiencies';
  static const sheetCustomerRejection = 'sheet_customer_rejection_reports';

  // Scrap / regrind
  static const scrapCleaning = 'scrap_cleaning_reports';
  static const scrapToolsCount = 'scrap_tools_count_reports';
  static const scrapHealth = 'scrap_machine_health_reports';
  static const scrapProductionDetails = 'scrap_production_details_reports';
  static const scrapProductionWeight = 'scrap_production_weight_reports';
  static const scrapWritingEfficiency = 'scrap_writing_efficiencies';
  static const scrapQuality = 'scrap_quality_reports';

  // Salary
  static const salaryCalculations = 'salary_calculations';
  static const scrapSalaryCalculations = 'scrap_salary_calculations';

  // Dashboard counters
  static const stockTotals = 'stock_totals';
  static const stockVariants = 'stock_variants';
}
```

`lib/core/data/firestore_support.dart`:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

/// `yyyy-MM-dd` — the storage format for every date-only field.
String dateKey(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

/// Parses a stored date (string or Timestamp) to local midnight.
DateTime parseDateKey(Object? v) {
  if (v is String) {
    final p = DateTime.parse(v);
    return DateTime(p.year, p.month, p.day);
  }
  if (v is Timestamp) {
    final d = v.toDate();
    return DateTime(d.year, d.month, d.day);
  }
  throw FormatException('Expected a date string, got ${v.runtimeType}');
}

Timestamp? toTimestamp(DateTime? d) => d == null ? null : Timestamp.fromDate(d);

DateTime? fromTimestamp(Object? v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

/// A document (or an embedded map) with typed, null-tolerant getters.
class DocRow {
  const DocRow(this.id, this.data);

  factory DocRow.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> s) =>
      DocRow(s.id, s.data() ?? <String, dynamic>{});

  final String id;
  final Map<String, dynamic> data;

  String str(String k, [String fallback = '']) {
    final v = data[k];
    return v is String ? v : fallback;
  }

  String? strOrNull(String k) {
    final v = data[k];
    return v is String ? v : null;
  }

  int integer(String k) => (data[k] as num?)?.toInt() ?? 0;

  double real(String k) => (data[k] as num?)?.toDouble() ?? 0;

  double? realOrNull(String k) => (data[k] as num?)?.toDouble();

  bool flag(String k, {bool fallback = true}) {
    final v = data[k];
    return v is bool ? v : fallback;
  }

  DateTime date(String k) => parseDateKey(data[k]);

  DateTime? timestamp(String k) => fromTimestamp(data[k]);

  List<String> strings(String k) =>
      List<String>.from((data[k] as List?) ?? const []);

  List<DocRow> children(String k) => ((data[k] as List?) ?? const [])
      .map((e) => DocRow('', Map<String, dynamic>.from(e as Map)))
      .toList();
}

/// Shared query/write helpers for the report collections.
class Reports {
  Reports(this.db);
  final FirebaseFirestore db;

  /// Equivalent of the old `ListXxx(machineNumber, startDate, endDate)`
  /// queries: optional equality filter, inclusive date range, newest first.
  /// Null filters are ignored.
  Future<List<DocRow>> list(
    String collection, {
    String? equalsField,
    String? equalsValue,
    String dateField = 'date',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query<Map<String, dynamic>> q = db.collection(collection);
    if (equalsField != null && equalsValue != null) {
      q = q.where(equalsField, isEqualTo: equalsValue);
    }
    if (startDate != null) {
      q = q.where(dateField, isGreaterThanOrEqualTo: dateKey(startDate));
    }
    if (endDate != null) {
      q = q.where(dateField, isLessThanOrEqualTo: dateKey(endDate));
    }
    q = q.orderBy(dateField, descending: true);
    final snap = await q.get();
    return snap.docs.map(DocRow.fromSnapshot).toList();
  }

  Future<DocRow?> findOne(String collection, Map<String, Object> equals) async {
    Query<Map<String, dynamic>> q = db.collection(collection);
    equals.forEach((field, value) => q = q.where(field, isEqualTo: value));
    final snap = await q.limit(1).get();
    return snap.docs.isEmpty ? null : DocRow.fromSnapshot(snap.docs.first);
  }

  Map<String, dynamic> stamp(Map<String, dynamic> data) => {
    ...data,
    'timestamp': FieldValue.serverTimestamp(),
  };

  Future<String> add(String collection, Map<String, dynamic> data) async {
    final ref = db.collection(collection).doc();
    await ref.set(stamp(data));
    return ref.id;
  }

  Future<void> delete(String collection, String id) =>
      db.collection(collection).doc(id).delete();
}
```

`lib/core/data/stock_ledger.dart`:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

import 'collections.dart';

abstract class StockKind {
  static const frame = 'frame';
  static const sheet = 'sheet';
}

/// One variant's contribution to stock (counts are pieces).
class StockLine {
  const StockLine({
    required this.variant,
    required this.density,
    required this.color,
    this.produced = 0,
    this.packed = 0,
    this.rejected = 0,
    this.packedAmount = 0,
    this.rejectedAmount = 0,
  });

  final String variant; // frame section or sheet thickness
  final String density;
  final String color;
  final int produced;
  final int packed;
  final int rejected;

  /// Weight (frames) or running feet (sheets) represented by [packed] / [rejected].
  final double packedAmount;
  final double rejectedAmount;
}

class StockData {
  const StockData({
    required this.totalProduced,
    required this.totalPacked,
    required this.totalRejected,
    required this.variants,
  });

  final double totalProduced;
  final double totalPacked;
  final double totalRejected;
  final List<StockLine> variants;
}

/// Running stock counters, updated in the same batch as the report write so
/// the dashboard never has to scan every historical report.
class StockLedger {
  StockLedger._();

  static String _slug(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');

  static String variantDocId(String kind, StockLine l) =>
      '${kind}__${_slug(l.variant)}__${_slug(l.density)}__${_slug(l.color)}';

  /// [sign] is `1` when a report is submitted and `-1` when it is deleted.
  /// [producedAmount] is the report-level produced total (weight or feet).
  static void apply(
    WriteBatch batch,
    FirebaseFirestore db, {
    required String kind,
    required List<StockLine> lines,
    double producedAmount = 0,
    int sign = 1,
  }) {
    var packedAmount = 0.0;
    var rejectedAmount = 0.0;
    for (final l in lines) {
      packedAmount += l.packedAmount;
      rejectedAmount += l.rejectedAmount;
      batch.set(db.collection(Col.stockVariants).doc(variantDocId(kind, l)), {
        'kind': kind,
        'variant': l.variant,
        'density': l.density,
        'color': l.color,
        'produced': FieldValue.increment(sign * l.produced),
        'packed': FieldValue.increment(sign * l.packed),
        'rejected': FieldValue.increment(sign * l.rejected),
      }, SetOptions(merge: true));
    }
    batch.set(db.collection(Col.stockTotals).doc(kind), {
      'totalProduced': FieldValue.increment(sign * producedAmount),
      'totalPacked': FieldValue.increment(sign * packedAmount),
      'totalRejected': FieldValue.increment(sign * rejectedAmount),
    }, SetOptions(merge: true));
  }

  static Future<StockData> read(FirebaseFirestore db, String kind) async {
    final totals = await db.collection(Col.stockTotals).doc(kind).get();
    final t = totals.data() ?? const <String, dynamic>{};
    final variants = await db
        .collection(Col.stockVariants)
        .where('kind', isEqualTo: kind)
        .get();
    return StockData(
      totalProduced: (t['totalProduced'] as num?)?.toDouble() ?? 0,
      totalPacked: (t['totalPacked'] as num?)?.toDouble() ?? 0,
      totalRejected: (t['totalRejected'] as num?)?.toDouble() ?? 0,
      variants: variants.docs.map((d) {
        final m = d.data();
        return StockLine(
          variant: m['variant'] as String? ?? '',
          density: m['density'] as String? ?? '',
          color: m['color'] as String? ?? '',
          produced: (m['produced'] as num?)?.toInt() ?? 0,
          packed: (m['packed'] as num?)?.toInt() ?? 0,
          rejected: (m['rejected'] as num?)?.toInt() ?? 0,
        );
      }).toList(),
    );
  }
}
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/core/data`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/core/data test/core/data
git commit -m "feat: add Firestore support layer and stock ledger"
```

---

### Task 3: Security rules and indexes

**Files:**
- Modify: `firestore.rules`, `firestore.indexes.json`
- Create: `tools/gen_indexes.js`, `tools/firestore-rules-test/package.json`, `tools/firestore-rules-test/rules.test.js`

**Interfaces:**
- Produces: rules where signed-in users read everything and write reports/stock/salary; only admins (a `users/{auth.uid}` doc whose `roles` contains `admin`) write `users` and `master_*`.

- [ ] **Step 1: Write the failing rules test**

`tools/firestore-rules-test/package.json`:
```json
{
  "name": "firestore-rules-test",
  "private": true,
  "scripts": { "test": "node --test" },
  "devDependencies": { "@firebase/rules-unit-testing": "^3.0.4", "firebase": "^10.12.0" }
}
```
`tools/firestore-rules-test/rules.test.js`:
```js
const { test, before, after } = require('node:test');
const assert = require('node:assert');
const fs = require('node:fs');
const path = require('node:path');
const { initializeTestEnvironment, assertSucceeds, assertFails } =
  require('@firebase/rules-unit-testing');

let env;
before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'rules-test',
    firestore: { rules: fs.readFileSync(path.join(__dirname, '../../firestore.rules'), 'utf8') },
  });
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await db.doc('users/admin1').set({ uid: '+911', roles: ['admin'], isActive: true });
    await db.doc('users/op1').set({ uid: '+912', roles: ['machine_operator'], isActive: true });
    await db.doc('master_machines/m1').set({ name: 'Frame Machine 1' });
  });
});
after(async () => env.cleanup());

const as = (uid) => env.authenticatedContext(uid).firestore();
const anon = () => env.unauthenticatedContext().firestore();

test('anonymous cannot read or write anything', async () => {
  await assertFails(anon().doc('master_machines/m1').get());
  await assertFails(anon().doc('frame_cleaning_reports/r1').set({ a: 1 }));
});

test('signed-in operator can read masters and write reports, not masters/users', async () => {
  await assertSucceeds(as('op1').doc('master_machines/m1').get());
  await assertSucceeds(as('op1').doc('frame_cleaning_reports/r1').set({ a: 1 }));
  await assertSucceeds(as('op1').doc('stock_totals/frame').set({ totalProduced: 1 }));
  await assertFails(as('op1').doc('master_machines/m2').set({ name: 'x' }));
  await assertFails(as('op1').doc('users/op1').update({ roles: ['admin'] }));
});

test('admin can write masters and users', async () => {
  await assertSucceeds(as('admin1').doc('master_machines/m3').set({ name: 'y' }));
  await assertSucceeds(as('admin1').doc('users/newuser').set({ uid: '+913', roles: [] }));
});
```

- [ ] **Step 2: Run to verify failure**

```bash
cd tools/firestore-rules-test && npm install && cd ../..
firebase emulators:exec --only firestore --project rules-test "npm test --prefix tools/firestore-rules-test"
```
Expected: FAIL — placeholder rules deny everything, so "signed-in operator can read masters" fails.

- [ ] **Step 3: Write the rules**

`firestore.rules`:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    function signedIn() {
      return request.auth != null;
    }

    function isAdmin() {
      return signedIn()
        && exists(/databases/$(database)/documents/users/$(request.auth.uid))
        && 'admin' in get(/databases/$(database)/documents/users/$(request.auth.uid)).data.roles;
    }

    function adminOnly(collection) {
      return collection == 'users' || collection.matches('master_.*');
    }

    match /{collection}/{docId} {
      allow read: if signedIn();
      allow write: if adminOnly(collection) ? isAdmin() : signedIn();
    }
  }
}
```

- [ ] **Step 4: Run rules tests**

Run the same `firebase emulators:exec ...` command. Expected: `# pass 3`, `# fail 0`.

- [ ] **Step 5: Generate composite indexes**

`tools/gen_indexes.js`:
```js
// Usage: node tools/gen_indexes.js > firestore.indexes.json
const machineDate = [
  'frame_cleaning_reports', 'frame_tools_count_reports', 'frame_health_reports',
  'frame_production_details_reports', 'frame_production_weight_reports', 'frame_shift_packing_reports',
  'sheet_cleaning_reports', 'sheet_tools_count_reports', 'sheet_health_reports',
  'sheet_production_details_reports', 'sheet_running_feet_reports', 'sheet_shift_packing_reports',
  'scrap_cleaning_reports', 'scrap_tools_count_reports', 'scrap_machine_health_reports',
  'scrap_production_details_reports', 'scrap_production_weight_reports',
  'scrap_quality_reports', 'scrap_writing_efficiencies',
].map((c) => [c, 'machineNumber', 'date']);
const operatorDate = ['frame_writing_efficiencies', 'sheet_writing_efficiencies']
  .map((c) => [c, 'operatorId', 'date']);
const rejection = ['frame_customer_rejection_reports', 'sheet_customer_rejection_reports']
  .map((c) => [c, 'machineNumber', 'originalProductionDate']);

const indexes = [...machineDate, ...operatorDate, ...rejection].map(([c, eq, d]) => ({
  collectionGroup: c,
  queryScope: 'COLLECTION',
  fields: [
    { fieldPath: eq, order: 'ASCENDING' },
    { fieldPath: d, order: 'DESCENDING' },
  ],
}));
console.log(JSON.stringify({ indexes, fieldOverrides: [] }, null, 2));
```
Run: `node tools/gen_indexes.js > firestore.indexes.json && python3 -c "import json;print(len(json.load(open('firestore.indexes.json'))['indexes']))"`
Expected: `23`.

- [ ] **Step 6: Commit**

```bash
git add firestore.rules firestore.indexes.json tools/gen_indexes.js tools/firestore-rules-test
echo "node_modules" > tools/firestore-rules-test/.gitignore
git add tools/firestore-rules-test/.gitignore
git commit -m "feat: add Firestore security rules, indexes and rules tests"
```

---

### Task 4: Auth (Firebase Auth login)

**Files:**
- Create: `lib/features/auth/data/auth_identity.dart`
- Rewrite: `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Test: `test/features/auth/auth_remote_datasource_test.dart`

**Interfaces:**
- Consumes: `Col.users`, `DocRow` (Task 2).
- Produces:
  - `AuthIdentity.normalizePhone(String) → String`, `AuthIdentity.emailFor(String phone) → String`, `AuthIdentity.passwordFor(String raw) → String`.
  - `AuthRemoteDataSourceImpl({required FirebaseAuth auth, required FirebaseFirestore firestore})` — `AuthRemoteDataSource` abstract interface unchanged (`signIn`, `signOut`, `getCurrentUser`).
  - Profile documents live at `users/{authUid}` with fields `uid, name, phone, email, roles, assignedMachines, fixedSalary, isActive`.

- [ ] **Step 1: Write the failing tests**

`test/features/auth/auth_remote_datasource_test.dart`:
```dart
import 'package:factory_app/features/auth/data/auth_identity.dart';
import 'package:factory_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthIdentity', () {
    test('normalizes phones and derives email/password', () {
      expect(AuthIdentity.normalizePhone('9876543210'), '+919876543210');
      expect(AuthIdentity.normalizePhone(' +919876543210 '), '+919876543210');
      expect(AuthIdentity.emailFor('9876543210'), '919876543210@prabitha.app');
      expect(AuthIdentity.emailFor('+919876543210'), '919876543210@prabitha.app');
      expect(AuthIdentity.passwordFor('1234'), 'prb#1234');
    });
  });

  group('AuthRemoteDataSourceImpl', () {
    late FakeFirebaseFirestore db;

    Future<void> profile({bool active = true}) => db.doc('users/auth-1').set({
      'uid': '+919876543210',
      'name': 'Ravi',
      'phone': '+919876543210',
      'email': '',
      'roles': ['machine_operator'],
      'assignedMachines': ['Frame Machine 1'],
      'fixedSalary': 1000,
      'isActive': active,
    });

    AuthRemoteDataSourceImpl build({bool signedIn = false}) {
      final auth = MockFirebaseAuth(
        signedIn: signedIn,
        mockUser: MockUser(uid: 'auth-1', email: '919876543210@prabitha.app'),
      );
      return AuthRemoteDataSourceImpl(auth: auth, firestore: db);
    }

    setUp(() => db = FakeFirebaseFirestore());

    test('signIn returns the profile keyed by the legacy uid', () async {
      await profile();
      final user = await build().signIn('9876543210', '1234');
      expect(user.uid, '+919876543210');
      expect(user.name, 'Ravi');
      expect(user.roles, ['machine_operator']);
      expect(user.assignedMachines, ['Frame Machine 1']);
      expect(user.fixedSalary, 1000);
    });

    test('signIn rejects a deactivated account and signs out', () async {
      await profile(active: false);
      final ds = build();
      await expectLater(ds.signIn('9876543210', '1234'),
          throwsA(predicate((e) => e.toString().contains('deactivated'))));
      expect(await ds.getCurrentUser(), isNull);
    });

    test('signIn rejects an Auth user without a profile', () async {
      await expectLater(build().signIn('9876543210', '1234'),
          throwsA(predicate((e) => e.toString().contains('No account found'))));
    });

    test('getCurrentUser restores a signed-in session and signOut clears it', () async {
      await profile();
      final ds = build(signedIn: true);
      expect((await ds.getCurrentUser())!.name, 'Ravi');
      await ds.signOut();
      expect(await ds.getCurrentUser(), isNull);
    });
  });
}
```

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/auth/auth_remote_datasource_test.dart`
Expected: FAIL — `auth_identity.dart` not found.

- [ ] **Step 3: Implement**

`lib/features/auth/data/auth_identity.dart`:
```dart
/// Maps the app's phone + password login onto Firebase Auth email/password.
class AuthIdentity {
  AuthIdentity._();

  static const _emailDomain = 'prabitha.app';

  /// Firebase Auth needs 6+ character passwords; legacy passwords are short
  /// (e.g. `1234`), so a constant prefix is added transparently.
  static const _passwordPrefix = 'prb#';

  static String normalizePhone(String phone) {
    final trimmed = phone.trim();
    if (trimmed.startsWith('+')) return trimmed;
    if (trimmed.length == 10) return '+91$trimmed';
    return trimmed;
  }

  static String emailFor(String phone) {
    final digits = normalizePhone(phone).replaceAll(RegExp(r'[^0-9]'), '');
    return '$digits@$_emailDomain';
  }

  static String passwordFor(String raw) => '$_passwordPrefix$raw';
}
```

`lib/features/auth/data/datasources/auth_remote_datasource.dart`:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../auth_identity.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String phone, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _db = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  @override
  Future<UserModel> signIn(String phone, String password) async {
    final UserCredential credential;
    try {
      credential = await _auth.signInWithEmailAndPassword(
        email: AuthIdentity.emailFor(phone),
        password: AuthIdentity.passwordFor(password),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_messageFor(e));
    }

    final user = await _loadProfile(credential.user!.uid);
    if (user == null) {
      await _auth.signOut();
      throw Exception('No account found for this phone number');
    }
    if (!user.isActive) {
      await _auth.signOut();
      throw Exception('Account is deactivated');
    }
    return user;
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final current = _auth.currentUser;
    if (current == null) return null;
    try {
      final user = await _loadProfile(current.uid);
      if (user == null || !user.isActive) {
        await _auth.signOut();
        return null;
      }
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> _loadProfile(String authUid) async {
    final snap = await _db.collection(Col.users).doc(authUid).get();
    if (!snap.exists) return null;
    final row = DocRow.fromSnapshot(snap);
    return UserModel(
      uid: row.str('uid'),
      name: row.str('name'),
      phone: row.str('phone'),
      email: row.str('email'),
      roles: row.strings('roles'),
      assignedMachines: row.strings('assignedMachines'),
      fixedSalary: row.real('fixedSalary'),
      isActive: row.flag('isActive'),
    );
  }

  String _messageFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for this phone number';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect phone number or password';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return e.message ?? 'Sign in failed';
    }
  }
}
```

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/auth/auth_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/auth test/features/auth/auth_remote_datasource_test.dart
git commit -m "feat(auth): sign in with Firebase Auth and Firestore profiles"
```

---

### Task 5: Admin datasource (users, masters, lookups)

**Files:**
- Create: `lib/features/admin/data/datasources/user_account_creator.dart`
- Rewrite: `lib/features/admin/data/datasources/admin_remote_datasource.dart`
- Test: `test/features/admin/admin_remote_datasource_test.dart`

**Interfaces:**
- Consumes: `Col`, `DocRow`, `AuthIdentity`.
- Produces: `abstract class UserAccountCreator { Future<String> create({required String email, required String password}); }` (returns the new Auth uid); `SecondaryAppAccountCreator implements UserAccountCreator`; `AdminRemoteDatasource({required FirebaseFirestore firestore, required UserAccountCreator accounts})` with the **same public methods and signatures** as today: `getAllUsers, getUserById, createUser, updateUser, toggleUserActive, getMasterTable, insertMasterItem, updateMasterItem, deleteMasterItem, getWeightTable, insertWeightEntry, updateWeightEntry, deleteWeightEntry, getTargetTable, insertTargetEntry, updateTargetEntry, deleteTargetEntry, getSalaryWeightages({category}), insertSalaryWeightage, updateSalaryWeightage, deleteSalaryWeightage`.

Behaviour decisions (see spec amendments): `updateUser` throws if the phone changed; master insert throws `Exception('… already exists')` on a duplicate value; weight insert on an existing (key1,key2) pair updates that row's weight (using the existing `_keysMatch` numeric-tolerant comparison); renaming a section/density/thickness updates the master doc in place and rewrites matching weight/target rows.

- [ ] **Step 1: Write the failing tests**

`test/features/admin/admin_remote_datasource_test.dart`:
```dart
import 'package:factory_app/features/admin/data/datasources/admin_remote_datasource.dart';
import 'package:factory_app/features/admin/data/datasources/user_account_creator.dart';
import 'package:factory_app/features/admin/domain/entities/admin_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAccounts implements UserAccountCreator {
  final created = <String>[];
  @override
  Future<String> create({required String email, required String password}) async {
    created.add('$email|$password');
    return 'auth-${created.length}';
  }
}

void main() {
  late FakeFirebaseFirestore db;
  late _FakeAccounts accounts;
  late AdminRemoteDatasource ds;

  setUp(() {
    db = FakeFirebaseFirestore();
    accounts = _FakeAccounts();
    ds = AdminRemoteDatasource(firestore: db, accounts: accounts);
  });

  group('users', () {
    test('createUser makes an Auth account and a profile keyed by auth uid', () async {
      await ds.createUser(
        name: 'Ravi', phone: '9876543210', password: '1234',
        roles: ['machine_operator'], assignedMachines: ['Frame Machine 1'], fixedSalary: 500,
      );
      expect(accounts.created.single, '919876543210@prabitha.app|prb#1234');
      final doc = await db.doc('users/auth-1').get();
      expect(doc.data()!['uid'], '+919876543210');
      expect(doc.data()!.containsKey('password'), isFalse);
      final all = await ds.getAllUsers();
      expect(all.single.uid, '+919876543210');
      expect(all.single.isActive, isTrue);
    });

    test('update and toggle find the user by legacy uid; phone change is rejected', () async {
      await ds.createUser(name: 'A', phone: '+919876543210', password: 'p',
          roles: [], assignedMachines: [], fixedSalary: 0);
      final u = (await ds.getAllUsers()).single;
      await ds.updateUser(ManagedUser(uid: u.uid, name: 'B', phone: u.phone,
          roles: ['admin'], assignedMachines: [], fixedSalary: 9, isActive: true));
      expect((await ds.getUserById(u.uid)).name, 'B');
      await ds.toggleUserActive(u.uid, false);
      expect((await ds.getUserById(u.uid)).isActive, isFalse);
      await expectLater(
        ds.updateUser(ManagedUser(uid: u.uid, name: 'B', phone: '+910000000000',
            roles: [], assignedMachines: [], fixedSalary: 9, isActive: true)),
        throwsA(predicate((e) => e.toString().contains('phone'))),
      );
    });
  });

  group('master tables', () {
    test('insert, list ordered by sortOrder, update, delete', () async {
      await ds.insertMasterItem(MasterTableType.machines,
          const MasterTableItem(id: '', value: 'Frame Machine 2', type: 'frame', sortOrder: 2, isActive: true));
      await ds.insertMasterItem(MasterTableType.machines,
          const MasterTableItem(id: '', value: 'Frame Machine 1', sortOrder: 1, isActive: true));
      final items = await ds.getMasterTable(MasterTableType.machines);
      expect(items.map((i) => i.value), ['Frame Machine 1', 'Frame Machine 2']);
      expect(items.first.type, 'frame'); // default when no type supplied
      await ds.updateMasterItem(MasterTableType.machines,
          MasterTableItem(id: items.first.id, value: 'Frame Machine 1', type: 'frame', sortOrder: 1, isActive: false));
      expect((await ds.getMasterTable(MasterTableType.machines)).first.isActive, isFalse);
      await ds.deleteMasterItem(MasterTableType.machines, items.first.id);
      expect(await ds.getMasterTable(MasterTableType.machines), hasLength(1));
    });

    test('duplicate value is rejected', () async {
      const item = MasterTableItem(id: '', value: 'Red', sortOrder: 1, isActive: true);
      await ds.insertMasterItem(MasterTableType.frameColors, item);
      await expectLater(ds.insertMasterItem(MasterTableType.frameColors, item),
          throwsA(predicate((e) => e.toString().contains('already exists'))));
    });

    test('roles store code and displayName', () async {
      await ds.insertMasterItem(MasterTableType.roles,
          const MasterTableItem(id: '', value: 'admin', displayName: 'Administrator', sortOrder: 1, isActive: true));
      final r = (await ds.getMasterTable(MasterTableType.roles)).single;
      expect([r.value, r.displayName], ['admin', 'Administrator']);
    });

    test('renaming a frame section rewrites weights and targets', () async {
      await ds.insertMasterItem(MasterTableType.frameSections,
          const MasterTableItem(id: '', value: '3x2', sortOrder: 1, isActive: true));
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.8', weight: 1.5));
      await ds.insertTargetEntry(MasterLookupType.frameTargets,
          const MasterTargetEntry(id: '', key: '3x2', density: '0.8', target: 40));
      final sec = (await ds.getMasterTable(MasterTableType.frameSections)).single;
      await ds.updateMasterItem(MasterTableType.frameSections,
          MasterTableItem(id: sec.id, value: '3x3', sortOrder: 1, isActive: true));
      expect((await ds.getMasterTable(MasterTableType.frameSections)).single.value, '3x3');
      expect((await ds.getWeightTable(MasterLookupType.frameWeights)).single.key1, '3x3');
      expect((await ds.getTargetTable(MasterLookupType.frameTargets)).single.key, '3x3');
    });
  });

  group('lookup tables', () {
    test('inserting an existing weight cell (0.8 vs 0.80) updates it instead', () async {
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.8', weight: 1));
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.80', weight: 2));
      final rows = await ds.getWeightTable(MasterLookupType.frameWeights);
      expect(rows, hasLength(1));
      expect(rows.single.weight, 2);
    });

    test('sheet targets require density; scrap targets do not', () async {
      await expectLater(
        ds.insertTargetEntry(MasterLookupType.sheetTargets,
            const MasterTargetEntry(id: '', key: '9mm', target: 5)),
        throwsA(isA<ArgumentError>()),
      );
      await ds.insertTargetEntry(MasterLookupType.scrapTargets,
          const MasterTargetEntry(id: '', key: 'Crusher', target: 80));
      final t = (await ds.getTargetTable(MasterLookupType.scrapTargets)).single;
      expect([t.key, t.density, t.target], ['Crusher', null, 80]);
    });

    test('salary weightages filter by category and support CRUD', () async {
      await ds.insertSalaryWeightage(const MasterSalaryWeightageEntry(
          id: '', variable: 'wA', label: 'Cleaning', category: 'frame_sheet', percentage: 15));
      await ds.insertSalaryWeightage(const MasterSalaryWeightageEntry(
          id: '', variable: 'wA', label: 'Cleaning %', category: 'scrap', percentage: 20));
      final fs = await ds.getSalaryWeightages();
      expect(fs.single.percentage, 15);
      await ds.updateSalaryWeightage(MasterSalaryWeightageEntry(
          id: fs.single.id, variable: 'wA', label: 'Cleaning', category: 'frame_sheet', percentage: 18));
      expect((await ds.getSalaryWeightages()).single.percentage, 18);
      await ds.deleteSalaryWeightage(fs.single.id);
      expect(await ds.getSalaryWeightages(), isEmpty);
      expect(await ds.getSalaryWeightages(category: 'scrap'), hasLength(1));
    });
  });
}
```

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/admin/admin_remote_datasource_test.dart`
Expected: FAIL — `user_account_creator.dart` not found.

- [ ] **Step 3: Implement `user_account_creator.dart`**

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Creates a Firebase Auth account without signing the current admin out.
abstract class UserAccountCreator {
  /// Returns the new account's Auth uid.
  Future<String> create({required String email, required String password});
}

class SecondaryAppAccountCreator implements UserAccountCreator {
  static const _appName = 'account-creator';

  Future<FirebaseApp> _app() async {
    try {
      return Firebase.app(_appName);
    } catch (_) {
      return Firebase.initializeApp(
        name: _appName,
        options: Firebase.app().options,
      );
    }
  }

  @override
  Future<String> create({required String email, required String password}) async {
    final auth = FirebaseAuth.instanceFor(app: await _app());
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('A user with this phone number already exists');
      }
      rethrow;
    } finally {
      await auth.signOut();
    }
  }
}
```

- [ ] **Step 4: Implement `admin_remote_datasource.dart`**

Replace the whole file:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../auth/data/auth_identity.dart';
import '../../domain/entities/admin_entities.dart';
import '../models/admin_models.dart';
import 'user_account_creator.dart';

bool _keysMatch(String a, String b) {
  final left = a.trim();
  final right = b.trim();
  if (left == right) return true;
  final na = double.tryParse(left);
  final nb = double.tryParse(right);
  return na != null && nb != null && na == nb;
}

class _MasterSpec {
  const _MasterSpec(
    this.collection,
    this.valueField, {
    this.typeField,
    this.displayField,
    this.renames = const [],
  });

  final String collection;
  final String valueField;
  final String? typeField; // machine `type`, maintenance `category`
  final String? displayField; // role `displayName`

  /// Weight/target collections + field that hold this master's value.
  final List<(String collection, String field)> renames;
}

const _masterSpecs = <MasterTableType, _MasterSpec>{
  MasterTableType.machines: _MasterSpec(Col.masterMachines, 'name', typeField: 'type'),
  MasterTableType.shifts: _MasterSpec(Col.masterShifts, 'name'),
  MasterTableType.roles: _MasterSpec(Col.masterRoles, 'code', displayField: 'displayName'),
  MasterTableType.frameSections: _MasterSpec(Col.masterFrameSections, 'name', renames: [
    (Col.masterFrameWeights, 'section'),
    (Col.masterFrameTargets, 'section'),
  ]),
  MasterTableType.frameDensities: _MasterSpec(Col.masterFrameDensities, 'value', renames: [
    (Col.masterFrameWeights, 'density'),
    (Col.masterFrameTargets, 'density'),
  ]),
  MasterTableType.frameColors: _MasterSpec(Col.masterFrameColors, 'name'),
  MasterTableType.sheetThicknesses: _MasterSpec(Col.masterSheetThicknesses, 'value', renames: [
    (Col.masterSheetWeights, 'thickness'),
    (Col.masterSheetTargets, 'thickness'),
  ]),
  MasterTableType.sheetDensities: _MasterSpec(Col.masterSheetDensities, 'value', renames: [
    (Col.masterSheetWeights, 'density'),
    (Col.masterSheetTargets, 'density'),
  ]),
  MasterTableType.sheetColors: _MasterSpec(Col.masterSheetColors, 'name'),
  MasterTableType.maintenanceItems: _MasterSpec(Col.masterMaintenanceItems, 'name', typeField: 'category'),
  MasterTableType.scrapProducts: _MasterSpec(Col.masterScrapProducts, 'name'),
};

class _WeightSpec {
  const _WeightSpec(this.collection, this.key1, this.key2, this.weight);
  final String collection;
  final String key1;
  final String key2;
  final String weight;
}

const _weightSpecs = <MasterLookupType, _WeightSpec>{
  MasterLookupType.frameWeights: _WeightSpec(Col.masterFrameWeights, 'section', 'density', 'weightPerFoot'),
  MasterLookupType.sheetWeights: _WeightSpec(Col.masterSheetWeights, 'thickness', 'density', 'weightPerSqft'),
};

class _TargetSpec {
  const _TargetSpec(this.collection, this.key, this.density, this.target);
  final String collection;
  final String key;
  final String? density; // null for scrap targets
  final String target;
}

const _targetSpecs = <MasterLookupType, _TargetSpec>{
  MasterLookupType.frameTargets: _TargetSpec(Col.masterFrameTargets, 'section', 'density', 'targetKgPerHour'),
  MasterLookupType.sheetTargets: _TargetSpec(Col.masterSheetTargets, 'thickness', 'density', 'targetFeetPerHour'),
  MasterLookupType.scrapTargets: _TargetSpec(Col.masterScrapTargets, 'product', null, 'targetKgPerHour'),
};

class AdminRemoteDatasource {
  AdminRemoteDatasource({
    required FirebaseFirestore firestore,
    required UserAccountCreator accounts,
  }) : _db = firestore,
       _accounts = accounts;

  final FirebaseFirestore _db;
  final UserAccountCreator _accounts;

  // ─── User Management ───

  ManagedUserModel _toUser(DocRow u) => ManagedUserModel(
    uid: u.str('uid'),
    name: u.str('name'),
    phone: u.str('phone'),
    email: u.str('email'),
    roles: u.strings('roles'),
    assignedMachines: u.strings('assignedMachines'),
    fixedSalary: u.real('fixedSalary'),
    isActive: u.flag('isActive'),
  );

  Future<DocumentReference<Map<String, dynamic>>> _userRef(String uid) async {
    final snap = await _db
        .collection(Col.users)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) throw Exception('User not found');
    return snap.docs.first.reference;
  }

  Future<List<ManagedUserModel>> getAllUsers() async {
    final snap = await _db.collection(Col.users).get();
    return snap.docs.map((d) => _toUser(DocRow.fromSnapshot(d))).toList();
  }

  Future<ManagedUserModel> getUserById(String uid) async {
    final ref = await _userRef(uid);
    return _toUser(DocRow.fromSnapshot(await ref.get()));
  }

  Future<void> createUser({
    required String name,
    required String phone,
    required String password,
    required List<String> roles,
    required List<String> assignedMachines,
    required double fixedSalary,
  }) async {
    final normalized = AuthIdentity.normalizePhone(phone);
    final authUid = await _accounts.create(
      email: AuthIdentity.emailFor(normalized),
      password: AuthIdentity.passwordFor(password),
    );
    await _db.collection(Col.users).doc(authUid).set({
      'uid': normalized, // legacy identity: reports reference operators by it
      'name': name,
      'phone': normalized,
      'email': '',
      'roles': roles,
      'assignedMachines': assignedMachines,
      'fixedSalary': fixedSalary,
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUser(ManagedUser user) async {
    final ref = await _userRef(user.uid);
    final current = DocRow.fromSnapshot(await ref.get());
    if (current.str('phone') != user.phone) {
      throw Exception(
        'Changing a phone number is not supported. Deactivate this user and create a new one.',
      );
    }
    await ref.update({
      'name': user.name,
      'roles': user.roles,
      'assignedMachines': user.assignedMachines,
      'fixedSalary': user.fixedSalary,
      'isActive': user.isActive,
    });
  }

  Future<void> toggleUserActive(String uid, bool isActive) async {
    final ref = await _userRef(uid);
    await ref.update({'isActive': isActive});
  }

  // ─── Master Dropdown Tables ───

  Future<List<MasterTableItem>> getMasterTable(MasterTableType tableType) async {
    final spec = _masterSpecs[tableType]!;
    final snap = await _db.collection(spec.collection).orderBy('sortOrder').get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterTableItem(
        id: r.id,
        value: r.str(spec.valueField),
        type: spec.typeField == null ? null : r.strOrNull(spec.typeField!),
        displayName: spec.displayField == null ? null : r.strOrNull(spec.displayField!),
        sortOrder: r.integer('sortOrder'),
        isActive: r.flag('isActive'),
      );
    }).toList();
  }

  Map<String, dynamic> _masterData(_MasterSpec spec, MasterTableItem item) => {
    spec.valueField: item.value,
    if (spec.typeField != null) spec.typeField!: item.type ?? 'frame',
    if (spec.displayField != null) spec.displayField!: item.displayName ?? item.value,
    'sortOrder': item.sortOrder,
    'isActive': item.isActive,
  };

  Future<bool> _valueExists(_MasterSpec spec, String value, {String? exceptId}) async {
    final snap = await _db
        .collection(spec.collection)
        .where(spec.valueField, isEqualTo: value)
        .get();
    return snap.docs.any((d) => d.id != exceptId);
  }

  Future<void> insertMasterItem(MasterTableType tableType, MasterTableItem item) async {
    final spec = _masterSpecs[tableType]!;
    if (await _valueExists(spec, item.value)) {
      throw Exception('"${item.value}" already exists');
    }
    await _db.collection(spec.collection).add(_masterData(spec, item));
  }

  Future<void> updateMasterItem(MasterTableType tableType, MasterTableItem item) async {
    final spec = _masterSpecs[tableType]!;
    final ref = _db.collection(spec.collection).doc(item.id);
    final old = await ref.get();
    if (!old.exists) return;
    final oldValue = old.data()![spec.valueField] as String? ?? '';
    if (oldValue != item.value) {
      if (await _valueExists(spec, item.value, exceptId: item.id)) {
        throw Exception('"${item.value}" already exists');
      }
    }

    final batch = _db.batch();
    batch.update(ref, _masterData(spec, item));
    if (oldValue != item.value) {
      for (final (collection, field) in spec.renames) {
        final rows = await _db.collection(collection).where(field, isEqualTo: oldValue).get();
        for (final row in rows.docs) {
          batch.update(row.reference, {field: item.value});
        }
      }
    }
    await batch.commit();
  }

  Future<void> deleteMasterItem(MasterTableType tableType, String id) =>
      _db.collection(_masterSpecs[tableType]!.collection).doc(id).delete();

  // ─── Master Lookup Tables ───

  Future<List<MasterWeightEntry>> getWeightTable(MasterLookupType type) async {
    final spec = _weightSpecs[type];
    if (spec == null) return [];
    final snap = await _db.collection(spec.collection).get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterWeightEntry(
        id: r.id,
        key1: r.str(spec.key1),
        key2: r.str(spec.key2),
        weight: r.real(spec.weight),
      );
    }).toList();
  }

  Future<void> insertWeightEntry(MasterLookupType type, MasterWeightEntry entry) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    // The cell may already exist, often hidden by a 0.8 vs 0.80 key mismatch.
    // Write the new weight onto that row instead of creating a duplicate.
    final existing = await getWeightTable(type);
    final match = existing
        .where((row) => _keysMatch(row.key1, entry.key1) && _keysMatch(row.key2, entry.key2))
        .firstOrNull;
    if (match != null) {
      await updateWeightEntry(
        type,
        MasterWeightEntry(id: match.id, key1: match.key1, key2: match.key2, weight: entry.weight),
      );
      return;
    }
    await _db.collection(spec.collection).add({
      spec.key1: entry.key1,
      spec.key2: entry.key2,
      spec.weight: entry.weight,
    });
  }

  Future<void> updateWeightEntry(MasterLookupType type, MasterWeightEntry entry) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(entry.id).update({
      spec.key1: entry.key1,
      spec.key2: entry.key2,
      spec.weight: entry.weight,
    });
  }

  Future<void> deleteWeightEntry(MasterLookupType type, String id) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(id).delete();
  }

  Future<List<MasterTargetEntry>> getTargetTable(MasterLookupType type) async {
    final spec = _targetSpecs[type];
    if (spec == null) return [];
    final snap = await _db.collection(spec.collection).get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterTargetEntry(
        id: r.id,
        key: r.str(spec.key),
        density: spec.density == null ? null : r.str(spec.density!),
        target: r.real(spec.target),
      );
    }).toList();
  }

  void _requireDensity(_TargetSpec spec, MasterTargetEntry entry, MasterLookupType type) {
    if (spec.density != null && (entry.density == null || entry.density!.isEmpty)) {
      throw ArgumentError(
        'Density is required for ${type == MasterLookupType.frameTargets ? 'frame' : 'sheet'} targets',
      );
    }
  }

  Map<String, dynamic> _targetData(_TargetSpec spec, MasterTargetEntry entry) => {
    spec.key: entry.key,
    if (spec.density != null) spec.density!: entry.density,
    spec.target: entry.target,
  };

  Future<void> insertTargetEntry(MasterLookupType type, MasterTargetEntry entry) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    _requireDensity(spec, entry, type);
    final existing = await getTargetTable(type);
    final duplicate = existing.any(
      (row) =>
          _keysMatch(row.key, entry.key) &&
          (spec.density == null || _keysMatch(row.density ?? '', entry.density ?? '')),
    );
    if (duplicate) throw Exception('A target for "${entry.key}" already exists');
    await _db.collection(spec.collection).add(_targetData(spec, entry));
  }

  Future<void> updateTargetEntry(MasterLookupType type, MasterTargetEntry entry) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    _requireDensity(spec, entry, type);
    await _db.collection(spec.collection).doc(entry.id).update(_targetData(spec, entry));
  }

  Future<void> deleteTargetEntry(MasterLookupType type, String id) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(id).delete();
  }

  // ─── Salary Weightages ───

  Future<List<MasterSalaryWeightageEntry>> getSalaryWeightages({
    String category = 'frame_sheet',
  }) async {
    final snap = await _db
        .collection(Col.masterSalaryWeightages)
        .where('category', isEqualTo: category)
        .get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterSalaryWeightageEntry(
        id: r.id,
        variable: r.str('variable'),
        label: r.str('label'),
        category: r.str('category'),
        percentage: r.real('percentage'),
      );
    }).toList();
  }

  Map<String, dynamic> _weightageData(MasterSalaryWeightageEntry e) => {
    'variable': e.variable,
    'label': e.label,
    'category': e.category,
    'percentage': e.percentage,
  };

  Future<void> insertSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _db.collection(Col.masterSalaryWeightages).add(_weightageData(entry));

  Future<void> updateSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _db.collection(Col.masterSalaryWeightages).doc(entry.id).update(_weightageData(entry));

  Future<void> deleteSalaryWeightage(String id) =>
      _db.collection(Col.masterSalaryWeightages).doc(id).delete();
}
```
Note: the old file's `getUserById` threw `Exception('User not found')`; `_userRef` preserves that.

- [ ] **Step 5: Run tests**

Run: `flutter test test/features/admin/admin_remote_datasource_test.dart`
Expected: `All tests passed!`. If `fake_cloud_firestore` rejects the `orderBy('sortOrder')` on documents missing the field, ensure every inserted master has `sortOrder` (tests do).

- [ ] **Step 6: Commit**

```bash
git add lib/features/admin/data/datasources test/features/admin/admin_remote_datasource_test.dart
git commit -m "feat(admin): move users, masters and lookups to Firestore"
```

---

### Task 6: Frames datasource (and the report-translation recipe)

**Files:**
- Rewrite: `lib/features/frames/data/datasources/frame_remote_datasource.dart`
- Test: `test/features/frames/frame_remote_datasource_test.dart`

**Interfaces:**
- Consumes: Task 2 helpers, `Col.frame*`, `StockLedger`.
- Produces: `FrameRemoteDataSourceImpl({required FirebaseFirestore firestore})`; the abstract `FrameRemoteDataSource` interface (lines 1–73 of the current file) stays **byte-for-byte identical** except for the imports.

**Translation recipe** (Tasks 7, 8 and 9 reuse it):
- `connector.createX(...).execute()` → `_reports.add(Col.x, {field: value, …})`; dates via `dateKey(...)`, instants via `toTimestamp(...)`.
- Parent + child inserts → one document with the children embedded as a list of maps.
- `listXs(machineNumber,startDate,endDate)` → `_reports.list(Col.x, equalsField: 'machineNumber', equalsValue: machineNumber, startDate:…, endDate:…)`, then map each `DocRow` using the same entity constructor arguments the old code used (`r.id` → `r.id`, `r.foo` → `r.str/integer/real('foo')`, `r.date` → `r.date('date')`, `r.submittedAt?.toDateTime()` → `r.timestamp('submittedAt')`).
- Delete → `_reports.delete(Col.x, id)`.
- Production/packing reports additionally maintain `StockLedger` in the same `WriteBatch` (production +, deletion −).

- [ ] **Step 1: Write the failing tests**

`test/features/frames/frame_remote_datasource_test.dart`:
```dart
import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:factory_app/features/frames/data/datasources/frame_remote_datasource.dart';
import 'package:factory_app/features/frames/domain/entities/frame_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

MachineCleaningReport _cleaning(String machine, DateTime d) => MachineCleaningReport(
  date: d, machineNumber: machine, machineCondition: 5, groundCondition: 4,
  mouldCondition: 3, totalScore: 12, percentage: 80, createdBy: 'u1',
);

FrameProductionDetailsReport _production({int qty = 10, double weight = 50}) =>
    FrameProductionDetailsReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      lineItems: [
        FrameProductionLineItem(section: '3x2', density: '0.8', color: 'White',
            length: 10, quantity: qty, perPieceWeight: 5, totalWeight: weight),
      ],
      totalQuantity: qty, totalWeight: weight, createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    );

void main() {
  late FakeFirebaseFirestore db;
  late FrameRemoteDataSourceImpl ds;
  setUp(() {
    db = FakeFirebaseFirestore();
    ds = FrameRemoteDataSourceImpl(firestore: db);
  });

  test('cleaning reports: machine + inclusive date filters, newest first, delete', () async {
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 1', DateTime(2026, 11, 1)));
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 1', DateTime(2026, 11, 10)));
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 2', DateTime(2026, 11, 10)));

    final all = await ds.getMachineCleaningReports();
    expect(all, hasLength(3));
    expect(all.first.date, DateTime(2026, 11, 10));

    final filtered = await ds.getMachineCleaningReports(
      machineNumber: 'Frame Machine 1',
      startDate: DateTime(2026, 11, 5),
      endDate: DateTime(2026, 11, 10, 23, 59, 59),
    );
    expect(filtered.single.date, DateTime(2026, 11, 10));
    expect(filtered.single.percentage, 80);
    expect(filtered.single.timestamp, isNotNull);

    await ds.deleteMachineCleaningReport(filtered.single.id!);
    expect(await ds.getMachineCleaningReports(), hasLength(2));
  });

  test('health report embeds entries and round-trips times', () async {
    await ds.submitMachineHealthReport(MachineHealthReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      entries: [
        FrameMaintenanceEntry(
          maintenanceItem: 'Oil', startTime: DateTime(2026, 11, 10, 8),
          endTime: DateTime(2026, 11, 10, 9), personDoingMaintenance: 'Ravi',
          description: 'routine', durationHours: 1,
        ),
      ],
      totalMaintenanceDurationHours: 1, createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    ));
    final r = (await ds.getMachineHealthReports()).single;
    expect(r.entries.single.maintenanceItem, 'Oil');
    expect(r.entries.single.startTime, DateTime(2026, 11, 10, 8));
    expect(r.submittedAt, DateTime(2026, 11, 10, 18));
    expect((await ds.getPendingApprovals()), hasLength(1));
  });

  test('production report round-trip, lookup by machine/date/shift, stock updates and reverses', () async {
    await ds.submitProductionDetailsReport(_production());
    final list = await ds.getProductionDetailsReports();
    expect(list.single.lineItems.single.section, '3x2');
    expect(list.single.totalWeight, 50);

    final found = await ds.getProductionDetailsReport(
        'Frame Machine 1', DateTime(2026, 11, 10, 14), 'Day');
    expect(found!.id, list.single.id);
    expect(await ds.getProductionDetailsReport('Frame Machine 1', DateTime(2026, 11, 11), 'Day'), isNull);

    var stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalProduced, 50);
    expect(stock.variants.single.produced, 10);

    await ds.deleteProductionDetailsReport(list.single.id!);
    stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalProduced, 0);
    expect(stock.variants.single.produced, 0);
  });

  test('packing report updates packed/rejected stock using per-piece weight and reverses on delete', () async {
    await ds.submitProductionDetailsReport(_production());
    await ds.submitShiftPackingReport(FrameShiftPackingReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      lineItems: [
        FramePackingLineItem(section: '3x2', density: '0.8', color: 'White', length: 10,
            productionQuantity: 10, perPieceWeight: 5, packed: 6, rejectedQuality: 1),
      ],
      totalRejectedWeight: 5, qualityAcceptancePercentage: 90, packingEfficiency: 60,
      createdBy: 'u1',
    ));
    var stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalPacked, 30); // 6 * 5
    expect(stock.totalRejected, 5); // 1 * 5
    expect([stock.variants.single.packed, stock.variants.single.rejected], [6, 1]);

    final id = (await ds.getShiftPackingReports()).single.id!;
    await ds.deleteShiftPackingReport(id);
    stock = await StockLedger.read(db, StockKind.frame);
    expect([stock.totalPacked, stock.totalRejected], [0, 0]);
  });

  test('writing efficiency filters by operatorId', () async {
    for (final op in ['a', 'b']) {
      await ds.submitWritingEfficiency(ReportWritingEfficiencyRecord(
        date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
        shiftEndTime: DateTime(2026, 11, 10, 18), score: 4, operatorId: op,
      ));
    }
    final r = await ds.getReportWritingEfficiency(operatorId: 'a');
    expect(r.single.operatorId, 'a');
    expect(r.single.shiftEndTime, DateTime(2026, 11, 10, 18));
    expect(r.single.submittedAt, isNotNull); // defaults to now
  });

  test('customer rejection is filtered and ordered by originalProductionDate', () async {
    await ds.submitCustomerRejectionReport(FrameCustomerRejectionReport(
      originalProductionDate: DateTime(2026, 10, 1), rejectionDate: DateTime(2026, 11, 2),
      machineNumber: 'Frame Machine 1', shift: 'Day',
      rejectedItems: [
        FrameProductionLineItem(section: '3x2', density: '0.8', color: 'White',
            length: 10, quantity: 2, perPieceWeight: 5, totalWeight: 10),
      ],
      totalRejectedWeight: 10, createdBy: 'u1',
    ));
    final inRange = await ds.getCustomerRejectionReports(
        startDate: DateTime(2026, 9, 30), endDate: DateTime(2026, 10, 31));
    expect(inRange.single.rejectedItems.single.quantity, 2);
    expect(inRange.single.rejectionDate, DateTime(2026, 11, 2));
    expect(await ds.getCustomerRejectionReports(startDate: DateTime(2026, 11, 1)), isEmpty);
  });
}
```
(Constructor argument lists for `MachineHealthReport`, `FramePackingLineItem`, `FrameShiftPackingReport`, `FrameCustomerRejectionReport`, `ReportWritingEfficiencyRecord` must match the entities in `lib/features/frames/domain/entities/frame_entities.dart`; they mirror the argument lists used by the old datasource shown there. If a named parameter differs, fix the test to the entity — do not change the entity.)

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/frames/frame_remote_datasource_test.dart`
Expected: FAIL — `FrameRemoteDataSourceImpl` has no `firestore` named parameter.

- [ ] **Step 3: Implement**

In `lib/features/frames/data/datasources/frame_remote_datasource.dart`: replace the two import lines `package:firebase_data_connect/...` and `.../generated/dataconnect/default.dart` with:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../../core/data/stock_ledger.dart';
```
Keep the `abstract class FrameRemoteDataSource { … }` block and the `frame_entities.dart` import unchanged. Replace everything from `class FrameRemoteDataSourceImpl` to the end with:

```dart
class FrameRemoteDataSourceImpl implements FrameRemoteDataSource {
  FrameRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<List<DocRow>> _list(
    String collection, {
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
    String equalsField = 'machineNumber',
    String? equalsValue,
    String dateField = 'date',
  }) => _reports.list(
    collection,
    equalsField: equalsField,
    equalsValue: equalsValue ?? machineNumber,
    dateField: dateField,
    startDate: startDate,
    endDate: endDate,
  );

  // ── embedded item mapping ──

  Map<String, dynamic> _productionItemToMap(FrameProductionLineItem i) => {
    'section': i.section,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'quantity': i.quantity,
    'perPieceWeight': i.perPieceWeight,
    'totalWeight': i.totalWeight,
    'manualWeightPerFoot': i.manualWeightPerFoot,
  };

  FrameProductionLineItem _productionItem(DocRow li) => FrameProductionLineItem(
    section: li.str('section'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    quantity: li.integer('quantity'),
    perPieceWeight: li.real('perPieceWeight'),
    totalWeight: li.real('totalWeight'),
    manualWeightPerFoot: li.realOrNull('manualWeightPerFoot'),
  );

  Map<String, dynamic> _packingItemToMap(FramePackingLineItem i) => {
    'section': i.section,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'productionQuantity': i.productionQuantity,
    'perPieceWeight': i.perPieceWeight,
    'packed': i.packed,
    'rejectedQuality': i.rejectedQuality,
  };

  FramePackingLineItem _packingItem(DocRow li) => FramePackingLineItem(
    section: li.str('section'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    productionQuantity: li.integer('productionQuantity'),
    perPieceWeight: li.real('perPieceWeight'),
    packed: li.integer('packed'),
    rejectedQuality: li.integer('rejectedQuality'),
  );

  Map<String, dynamic> _entryToMap(FrameMaintenanceEntry e) => {
    'maintenanceItem': e.maintenanceItem,
    'startTime': toTimestamp(e.startTime),
    'endTime': toTimestamp(e.endTime),
    'personDoingMaintenance': e.personDoingMaintenance,
    'description': e.description,
    'durationHours': e.durationHours,
  };

  FrameMaintenanceEntry _entry(DocRow e) => FrameMaintenanceEntry(
    maintenanceItem: e.str('maintenanceItem'),
    startTime: e.timestamp('startTime')!,
    endTime: e.timestamp('endTime')!,
    personDoingMaintenance: e.str('personDoingMaintenance'),
    description: e.str('description'),
    durationHours: e.real('durationHours'),
  );

  // ── stock helpers (operate on stored maps so submit and delete share them) ──

  List<StockLine> _productionStock(List<Map<String, dynamic>> items) => items
      .map((m) => DocRow('', m))
      .map(
        (i) => StockLine(
          variant: i.str('section'),
          density: i.str('density'),
          color: i.str('color'),
          produced: i.integer('quantity'),
        ),
      )
      .toList();

  List<StockLine> _packingStock(List<Map<String, dynamic>> items) => items
      .map((m) => DocRow('', m))
      .map(
        (i) => StockLine(
          variant: i.str('section'),
          density: i.str('density'),
          color: i.str('color'),
          packed: i.integer('packed'),
          rejected: i.integer('rejectedQuality'),
          packedAmount: i.integer('packed') * i.real('perPieceWeight'),
          rejectedAmount: i.integer('rejectedQuality') * i.real('perPieceWeight'),
        ),
      )
      .toList();

  List<Map<String, dynamic>> _rawChildren(DocRow row, String key) =>
      row.children(key).map((c) => c.data).toList();

  // ── Cleaning ──

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) async {
    await _reports.add(Col.frameCleaning, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'machineCondition': report.machineCondition,
      'groundCondition': report.groundCondition,
      'mouldCondition': report.mouldCondition,
      'totalScore': report.totalScore,
      'percentage': report.percentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameCleaning,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => MachineCleaningReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            machineCondition: r.integer('machineCondition'),
            groundCondition: r.integer('groundCondition'),
            mouldCondition: r.integer('mouldCondition'),
            totalScore: r.integer('totalScore'),
            percentage: r.real('percentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteMachineCleaningReport(String id) =>
      _reports.delete(Col.frameCleaning, id);

  // ── Tools count ──

  @override
  Future<void> submitToolsCountReport(ToolsCountReport report) async {
    await _reports.add(Col.frameToolsCount, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'totalToolsGiven': report.totalToolsGiven,
      'totalToolsAvailable': report.totalToolsAvailable,
      'percentageAvailable': report.percentageAvailable,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameToolsCount,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ToolsCountReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            totalToolsGiven: r.integer('totalToolsGiven'),
            totalToolsAvailable: r.integer('totalToolsAvailable'),
            percentageAvailable: r.real('percentageAvailable'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteToolsCountReport(String id) =>
      _reports.delete(Col.frameToolsCount, id);

  // ── Machine health ──

  @override
  Future<void> submitMachineHealthReport(MachineHealthReport report) async {
    await _reports.add(Col.frameHealth, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalMaintenanceDurationHours': report.totalMaintenanceDurationHours,
      'createdBy': report.createdBy,
      'submittedAt': toTimestamp(report.submittedAt),
      'entries': report.entries.map(_entryToMap).toList(),
    });
  }

  @override
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameHealth,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => MachineHealthReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            entries: r.children('entries').map(_entry).toList(),
            totalMaintenanceDurationHours: r.real('totalMaintenanceDurationHours'),
            createdBy: r.str('createdBy'),
            submittedAt: r.timestamp('submittedAt'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<List<MachineHealthReport>> getPendingApprovals() =>
      getMachineHealthReports();

  @override
  Future<void> deleteMachineHealthReport(String id) =>
      _reports.delete(Col.frameHealth, id);

  // ── Production details (maintains stock) ──

  @override
  Future<void> submitProductionDetailsReport(
    FrameProductionDetailsReport report,
  ) async {
    final items = report.lineItems.map(_productionItemToMap).toList();
    final ref = _db.collection(Col.frameProductionDetails).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalQuantity': report.totalQuantity,
        'totalWeight': report.totalWeight,
        'createdBy': report.createdBy,
        'submittedAt': toTimestamp(report.submittedAt),
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _productionStock(items),
      producedAmount: report.totalWeight,
    );
    await batch.commit();
  }

  FrameProductionDetailsReport _productionReport(DocRow r) =>
      FrameProductionDetailsReport(
        id: r.id,
        date: r.date('date'),
        machineNumber: r.str('machineNumber'),
        shift: r.str('shift'),
        lineItems: r.children('lineItems').map(_productionItem).toList(),
        totalQuantity: r.integer('totalQuantity'),
        totalWeight: r.real('totalWeight'),
        createdBy: r.str('createdBy'),
        submittedAt: r.timestamp('submittedAt'),
        timestamp: r.timestamp('timestamp'),
      );

  @override
  Future<List<FrameProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameProductionDetails,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows.map(_productionReport).toList();
  }

  @override
  Future<FrameProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final row = await _reports.findOne(Col.frameProductionDetails, {
      'machineNumber': machineNumber,
      'date': dateKey(date),
      'shift': shift,
    });
    return row == null ? null : _productionReport(row);
  }

  @override
  Future<void> deleteProductionDetailsReport(String id) async {
    final ref = _db.collection(Col.frameProductionDetails).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _productionStock(_rawChildren(row, 'lineItems')),
      producedAmount: row.real('totalWeight'),
      sign: -1,
    );
    await batch.commit();
  }

  // ── Production weight ──

  @override
  Future<void> submitProductionWeightReport(
    FrameProductionWeightReport report,
  ) async {
    await _reports.add(Col.frameProductionWeight, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'productionWeight': report.productionWeight,
      'maintenanceWeight': report.maintenanceWeight,
      'totalProductionWeight': report.totalProductionWeight,
      'targetWeight': report.targetWeight,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameProductionWeight,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameProductionWeightReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            productionWeight: r.real('productionWeight'),
            maintenanceWeight: r.real('maintenanceWeight'),
            totalProductionWeight: r.real('totalProductionWeight'),
            targetWeight: r.real('targetWeight'),
            efficiencyPercentage: r.real('efficiencyPercentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteProductionWeightReport(String id) =>
      _reports.delete(Col.frameProductionWeight, id);

  // ── Shift packing (maintains stock) ──

  @override
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report) async {
    final items = report.lineItems.map(_packingItemToMap).toList();
    final ref = _db.collection(Col.frameShiftPacking).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalRejectedWeight': report.totalRejectedWeight,
        'qualityAcceptancePercentage': report.qualityAcceptancePercentage,
        'packingEfficiency': report.packingEfficiency,
        'createdBy': report.createdBy,
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _packingStock(items),
    );
    await batch.commit();
  }

  @override
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameShiftPacking,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameShiftPackingReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            lineItems: r.children('lineItems').map(_packingItem).toList(),
            totalRejectedWeight: r.real('totalRejectedWeight'),
            qualityAcceptancePercentage: r.real('qualityAcceptancePercentage'),
            packingEfficiency: r.real('packingEfficiency'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteShiftPackingReport(String id) async {
    final ref = _db.collection(Col.frameShiftPacking).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _packingStock(_rawChildren(row, 'lineItems')),
      sign: -1,
    );
    await batch.commit();
  }

  // ── Writing efficiency ──

  @override
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameWritingEfficiency,
      equalsField: 'operatorId',
      equalsValue: operatorId,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ReportWritingEfficiencyRecord(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            submittedAt: r.timestamp('submittedAt'),
            shiftEndTime: r.timestamp('shiftEndTime')!,
            score: r.integer('score'),
            operatorId: r.str('operatorId'),
          ),
        )
        .toList();
  }

  @override
  Future<void> submitWritingEfficiency(ReportWritingEfficiencyRecord record) async {
    await _reports.add(Col.frameWritingEfficiency, {
      'date': dateKey(record.date),
      'machineNumber': record.machineNumber,
      'shift': record.shift,
      'shiftEndTime': toTimestamp(record.shiftEndTime),
      'score': record.score,
      'operatorId': record.operatorId,
      'submittedAt': toTimestamp(record.submittedAt ?? DateTime.now()),
    });
  }

  @override
  Future<void> deleteWritingEfficiency(String id) =>
      _reports.delete(Col.frameWritingEfficiency, id);

  // ── Customer rejection ──

  @override
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  ) async {
    await _reports.add(Col.frameCustomerRejection, {
      'originalProductionDate': dateKey(report.originalProductionDate),
      'rejectionDate': dateKey(report.rejectionDate),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalRejectedWeight': report.totalRejectedWeight,
      'createdBy': report.createdBy,
      'rejectedItems': report.rejectedItems.map(_productionItemToMap).toList(),
    });
  }

  @override
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameCustomerRejection,
      machineNumber: machineNumber,
      dateField: 'originalProductionDate',
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameCustomerRejectionReport(
            id: r.id,
            originalProductionDate: r.date('originalProductionDate'),
            rejectionDate: r.date('rejectionDate'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            rejectedItems: r.children('rejectedItems').map(_productionItem).toList(),
            totalRejectedWeight: r.real('totalRejectedWeight'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteCustomerRejectionReport(String id) =>
      _reports.delete(Col.frameCustomerRejection, id);
}
```
Behaviour note: stock is only touched by production-details and shift-packing reports, matching what the old dashboard summed. Customer-rejection reports never affected stock and still do not.

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/frames/frame_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/frames/data/datasources test/features/frames/frame_remote_datasource_test.dart
git commit -m "feat(frames): move frame reports to Firestore with stock ledger"
```

---

### Task 7: Sheets datasource

**Files:**
- Rewrite: `lib/features/sheets/data/datasources/sheet_remote_datasource.dart`
- Test: `test/features/sheets/sheet_remote_datasource_test.dart`

**Interfaces:**
- Consumes: Task 2 helpers; the Task 6 file as the worked example (same structure, helper names, `_list`, `_rawChildren`, stock helpers).
- Produces: `SheetRemoteDataSourceImpl({required FirebaseFirestore firestore})`; abstract interface unchanged.

Apply the Task 6 recipe to every method of the current file (it has the same 9 report families as frames, plus running-feet instead of production-weight). Entity classes and constructor argument names come from the **old method bodies you are replacing** — keep them exactly. Collections / fields / embedded keys:

| Method family | Collection (`Col.`) | Equality filter | Date field | Embedded key → item fields |
|---|---|---|---|---|
| cleaning | `sheetCleaning` | machineNumber | date | — (same fields as frame cleaning, incl. `mouldCondition`) |
| tools count | `sheetToolsCount` | machineNumber | date | — |
| health | `sheetHealth` | machineNumber | date | `entries`: maintenanceItem, startTime(ts), endTime(ts), personDoingMaintenance, description, durationHours |
| production details | `sheetProductionDetails` | machineNumber | date | `lineItems`: thickness, density, color, length, width, quantity, sqft, perPieceWeight, totalWeight, totalRunningFeet, timeOfChange(ts, nullable), manualWeightPerSqft(nullable). Report fields: totalQuantity, totalWeight, totalRunningFeet, createdBy, submittedAt(ts) |
| running feet | `sheetRunningFeet` | machineNumber | date | report fields: shift, productionRunningFeet, maintenanceRunningFeet, totalProductionRunningFeet, targetRunningFeet, efficiencyPercentage, createdBy |
| shift packing | `sheetShiftPacking` | machineNumber | date | `lineItems`: thickness, density, color, length, width, productionQuantity, perPieceWeight, runningFeetPerItem, packed, onlySanding, sandingAndPacked, rejectedQuality. Report fields: totalRejectedRunningFeet, qualityAcceptancePercentage, packingEfficiency, createdBy |
| writing efficiency | `sheetWritingEfficiency` | **operatorId** | date | fields as frames |
| customer rejection | `sheetCustomerRejection` | machineNumber | **originalProductionDate** | `rejectedItems`: thickness, density, color, length, width, quantity, sqft, perPieceWeight, totalWeight, totalRunningFeet. Report fields: originalProductionDate(date), machineNumber, shift, totalRejectedRunningFeet, createdBy (no `rejectionDate`) |

Sheet-specific rules:
- `getProductionDetailsReport(machineNumber, date, shift)` uses `_reports.findOne` with `{machineNumber, date: dateKey(date), shift}`.
- Stock kind is `StockKind.sheet`. **Production** submit/delete: `producedAmount = report.totalRunningFeet`; each line → `StockLine(variant: thickness, density, color, produced: quantity)`. **Packing** submit/delete: each line → `StockLine(variant: thickness, density, color, packed: packed, rejected: rejectedQuality, packedAmount: packed * runningFeetPerItem, rejectedAmount: rejectedQuality * runningFeetPerItem)`. Both use a `WriteBatch` with the report write and `StockLedger.apply`, and delete reads the stored document first and applies `sign: -1` — identical in shape to `submitProductionDetailsReport`, `deleteProductionDetailsReport`, `submitShiftPackingReport`, `deleteShiftPackingReport` in Task 6.
- `getPendingApprovals()` still returns `getMachineHealthReports()`.
- Writing-efficiency submit defaults `submittedAt` to `DateTime.now()` as in Task 6.

- [ ] **Step 1: Write the failing tests**

`test/features/sheets/sheet_remote_datasource_test.dart` — mirror the Task 6 test file against the sheet entities in `lib/features/sheets/domain/entities/sheet_entities.dart` (and the shared `MachineCleaningReport`, `ToolsCountReport`, `MachineHealthReport`, `ReportWritingEfficiencyRecord` from `frame_entities.dart`). It must contain at least these tests, using `SheetRemoteDataSourceImpl(firestore: FakeFirebaseFirestore())`:
1. cleaning: machine + inclusive date filtering, newest first, delete (same body as the frames test, with `'Sheet Machine 3'`).
2. production details: submit a report with one `SheetProductionLineItem(thickness:'9mm', density:'0.8', color:'White', length:10, width:4, quantity:10, sqft:40, perPieceWeight:5, totalWeight:50, totalRunningFeet:100, timeOfChange: DateTime(2026,11,10,9), manualWeightPerSqft: null)` and `totalRunningFeet: 100`; assert round trip incl. `timeOfChange == DateTime(2026,11,10,9)`; assert `StockLedger.read(db, StockKind.sheet)` gives `totalProduced == 100` and variant `produced == 10`; delete → both 0.
3. packing: submit a `SheetPackingLineItem(... productionQuantity:10, perPieceWeight:5, runningFeetPerItem:10, packed:6, onlySanding:0, sandingAndPacked:0, rejectedQuality:1 ...)`; assert `totalPacked == 60`, `totalRejected == 10`, packed/rejected counts 6/1; delete → zeros. The frame kind stays empty.
4. customer rejection: filter by `originalProductionDate` range.
5. running feet + writing efficiency (operatorId filter) round trips.

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/sheets/sheet_remote_datasource_test.dart`
Expected: FAIL — no `firestore` parameter.

- [ ] **Step 3: Implement**

Rewrite the file following the table and the Task 6 structure (swap the two `dataconnect` imports for the four imports from Task 6; keep the abstract class unchanged; class has `_db`, `_reports`, `_list`, `_rawChildren`, per-item `…ToMap` / `…` mappers, stock helpers).

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/sheets/sheet_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/sheets/data/datasources test/features/sheets/sheet_remote_datasource_test.dart
git commit -m "feat(sheets): move sheet reports to Firestore with stock ledger"
```

---

### Task 8: Scrap/regrind datasource (including scrap salary)

**Files:**
- Rewrite: `lib/features/scrap_regrind/data/datasources/scrap_regrind_remote_datasource.dart`
- Test: `test/features/scrap_regrind/scrap_remote_datasource_test.dart`

**Interfaces:**
- Consumes: Task 2 helpers; Task 6 as the worked example.
- Produces: `ScrapRegrindRemoteDataSourceImpl({required FirebaseFirestore firestore})`; abstract interface unchanged. No stock ledger (scrap has no dashboard stock).

| Method family | Collection | Equality filter | Embedded / fields |
|---|---|---|---|
| cleaning | `scrapCleaning` | machineNumber | date, machineNumber, machineCondition, groundCondition, totalScore, percentage, createdBy (**no mouldCondition**) |
| tools count | `scrapToolsCount` | machineNumber | totalToolsGiven, totalToolsAvailable, percentageAvailable |
| machine health | `scrapHealth` | machineNumber | shift, totalMaintenanceDurationHours, createdBy, submittedAt(ts); `entries`: maintenanceItem, startTime(ts), endTime(ts), personDoingMaintenance, description, durationHours. Also `getMachineHealthReport(machineNumber, date, shift)` via `findOne` |
| production details | `scrapProductionDetails` | machineNumber | shift, totalProductionWeight, createdBy, submittedAt(ts); `lineItems`: product, weightPerBag, totalBags, totalWeight. Also `getProductionDetailsReport(...)` via `findOne` |
| production weight | `scrapProductionWeight` | machineNumber | shift, totalProductionWeight, maintenanceWeight, totalWeight, targetWeight, efficiencyPercentage, createdBy |
| writing efficiency | `scrapWritingEfficiency` | **machineNumber, filled from the `operatorId` argument** | date, machineNumber, shift, submittedAt(ts), shiftEndTime(ts), score, operatorId |
| quality | `scrapQuality` | machineNumber | shift, product, qualityRating, comments(nullable), createdBy |
| salary | `scrapSalaryCalculations` | — | see below |

Notes:
- **Preserve the existing quirk:** `getReportWritingEfficiency(operatorId: …)` filters on `machineNumber` (the old code called `builder.machineNumber(operatorId)`). Keep that so callers behave identically: `_list(Col.scrapWritingEfficiency, equalsField: 'machineNumber', equalsValue: operatorId, …)`.
- `getSalaryWeightages()`: query `Col.masterSalaryWeightages` where `category == 'scrap'` and reproduce the old defaulting logic from the current method body verbatim (read it before replacing).
- `getMonthlyAggregates(operatorId, year, month)`: user lookup is `users` where `uid == operatorId` (limit 1); `machineNumber` = first `assignedMachines` entry, else `operatorId` (same as old code). Range = `DateTime(year, month, 1)` … `DateTime(year, month + 1, 0, 23, 59, 59)`. Run five `_list` calls (cleaning → `percentage`, tools → `percentageAvailable`, production weight → `efficiencyPercentage`, writing efficiency → `score`, quality → `qualityRating`), average each (`0.0` when empty), and return the same map keys the old code returned (read the end of the current method).
- `getFixedSalary` / `getOperatorName`: `users` where `uid == operatorId`; fallbacks identical to the old code (read it).
- `saveSalaryCalculation` → `_reports.add(Col.scrapSalaryCalculations, {operatorId, operatorName, year, month, a, b, e, f, g, wA, wB, wE, wF, wG, multiplier, fixedSalary, calculatedSalary})`; `getSavedCalculation` → `findOne(Col.scrapSalaryCalculations, {operatorId, year, month})` mapped with the same `ScrapSalaryCalculation(...)` arguments as the old code.

- [ ] **Step 1: Write the failing tests**

`test/features/scrap_regrind/scrap_remote_datasource_test.dart` using `FakeFirebaseFirestore` and the entities in `lib/features/scrap_regrind/domain/entities/scrap_regrind_entities.dart`. Required tests:
1. cleaning round trip with machine + date-range filter and delete.
2. health report embeds entries; `getMachineHealthReport(machine, date, shift)` finds it and returns `null` for another shift.
3. production details embeds `lineItems` (product/weightPerBag/totalBags/totalWeight) and `getProductionDetailsReport` finds it.
4. writing efficiency: submit two records with different `machineNumber`; `getReportWritingEfficiency(operatorId: '<machine name>')` returns only the matching one (documents the quirk).
5. `getMonthlyAggregates`: seed `users/u1` with `{uid:'+911', assignedMachines:['Crusher Machine 1']}`; submit for November 2026 one cleaning (percentage 80), one tools (percentageAvailable 60), one production weight (efficiencyPercentage 70), one writing efficiency (score 4), one quality (qualityRating 5) on `Crusher Machine 1`, plus an October cleaning (percentage 10) that must be excluded; assert the returned averages for November equal those values (use the map keys the old method returns).
6. salary: `saveSalaryCalculation` then `getSavedCalculation('+911', 2026, 11)` returns it; a different month returns `null`.

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/scrap_regrind/scrap_remote_datasource_test.dart`
Expected: FAIL — no `firestore` parameter.

- [ ] **Step 3: Implement**

Rewrite per the table and the Task 6 structure. Replace the `package:firebase_data_connect` and `generated/dataconnect` imports with the Task 6 core-data imports (without `stock_ledger.dart`).

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/scrap_regrind/scrap_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/scrap_regrind/data/datasources test/features/scrap_regrind/scrap_remote_datasource_test.dart
git commit -m "feat(scrap): move scrap/regrind reports and salary to Firestore"
```

---

### Task 9: Salary datasource (frames/sheets)

**Files:**
- Rewrite: `lib/features/salary/data/datasources/salary_remote_datasource.dart`
- Test: `test/features/salary/salary_remote_datasource_test.dart`

**Interfaces:**
- Consumes: `Reports`, `DocRow`, `Col`.
- Produces: `SalaryRemoteDataSourceImpl({required FirebaseFirestore firestore})`; `SalaryRemoteDataSource` interface unchanged.

- [ ] **Step 1: Write the failing tests**

`test/features/salary/salary_remote_datasource_test.dart`:
```dart
import 'package:factory_app/features/salary/data/datasources/salary_remote_datasource.dart';
import 'package:factory_app/features/salary/domain/entities/salary_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late SalaryRemoteDataSourceImpl ds;

  setUp(() async {
    db = FakeFirebaseFirestore();
    ds = SalaryRemoteDataSourceImpl(firestore: db);
    await db.doc('users/a1').set({
      'uid': '+911', 'name': 'Ravi', 'fixedSalary': 1500.0,
      'assignedMachines': ['Frame Machine 1'], 'roles': ['machine_operator'], 'isActive': true,
    });
    await db.doc('users/a2').set({
      'uid': '+912', 'name': 'Sita', 'fixedSalary': 0,
      'assignedMachines': ['Sheet Machine 3'], 'roles': ['machine_operator'], 'isActive': true,
    });
  });

  test('user lookups by legacy uid with fallbacks', () async {
    expect(await ds.getFixedSalary('+911'), 1500);
    expect(await ds.getOperatorName('+911'), 'Ravi');
    expect(await ds.getFixedSalary('nope'), 0);
    expect(await ds.getOperatorName('nope'), 'Unknown');
  });

  test('getWeightages falls back to defaults then reads master rows', () async {
    final defaults = await ds.getWeightages();
    expect(defaults.wA, greaterThan(0));
    await db.collection('master_salary_weightages').add(
        {'variable': 'wA', 'label': 'x', 'category': 'frame_sheet', 'percentage': 33.0});
    expect((await ds.getWeightages()).wA, 33);
  });

  test('frame operator aggregates average the month and ignore other months', () async {
    Future<void> add(String col, Map<String, dynamic> m) => db.collection(col).add(m);
    await add('frame_cleaning_reports', {'date': '2026-11-03', 'percentage': 80.0});
    await add('frame_cleaning_reports', {'date': '2026-11-20', 'percentage': 60.0});
    await add('frame_cleaning_reports', {'date': '2026-10-31', 'percentage': 0.0});
    await add('frame_tools_count_reports', {'date': '2026-11-03', 'percentageAvailable': 90.0});
    await add('frame_production_weight_reports',
        {'date': '2026-11-03', 'efficiencyPercentage': 70.0, 'createdBy': '+911'});
    await add('frame_production_weight_reports',
        {'date': '2026-11-04', 'efficiencyPercentage': 10.0, 'createdBy': '+999'});
    await add('frame_shift_packing_reports', {
      'date': '2026-11-05', 'qualityAcceptancePercentage': 95.0, 'packingEfficiency': 85.0});
    await add('frame_writing_efficiencies',
        {'date': '2026-11-05', 'operatorId': '+911', 'score': 4});

    final a = await ds.getOperatorAggregates('+911', 2026, 11);
    expect(a['a'], 70);
    expect(a['b'], 90);
    expect(a['c'], 70);
    expect(a['d'], 95);
    expect(a['e'], 85);
    expect(a['f'], 80); // 4/5*100
  });

  test('unknown operator returns zeros; sheet operators use sheet collections', () async {
    expect((await ds.getOperatorAggregates('nope', 2026, 11))['a'], 0);
    await db.collection('sheet_cleaning_reports').add({'date': '2026-11-03', 'percentage': 50.0});
    expect((await ds.getOperatorAggregates('+912', 2026, 11))['a'], 50);
  });

  test('save and read calculations; month list sorted by operator name', () async {
    SalaryCalculation calc(String id, String name) => SalaryCalculation(
      operatorId: id, operatorName: name, year: 2026, month: 11,
      a: 1, b: 2, c: 3, d: 4, e: 5, f: 6,
      wA: 10, wB: 10, wC: 10, wD: 10, wE: 10, wF: 10,
      multiplier: 1.1, fixedSalary: 100, calculatedSalary: 123,
    );
    await ds.saveSalaryCalculation(calc('+912', 'Sita'));
    await ds.saveSalaryCalculation(calc('+911', 'Ravi'));
    final saved = await ds.getSavedCalculation('+911', 2026, 11);
    expect(saved!.calculatedSalary, 123);
    expect(await ds.getSavedCalculation('+911', 2026, 10), isNull);
    final month = await ds.getCalculationsForMonth(2026, 11);
    expect(month.map((c) => c.operatorName), ['Ravi', 'Sita']);
  });
}
```
(`SalaryCalculation` constructor parameters must match `salary_entities.dart`; adjust the test, not the entity, if a required argument such as `id` differs.)

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/salary/salary_remote_datasource_test.dart`
Expected: FAIL — no `firestore` parameter.

- [ ] **Step 3: Implement**

Replace the file. Keep the abstract class (lines 5–21 of the current file) unchanged; imports become:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../domain/entities/salary_entities.dart';
```
Implementation:
```dart
class SalaryRemoteDataSourceImpl implements SalaryRemoteDataSource {
  SalaryRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<DocRow?> _user(String operatorId) =>
      _reports.findOne(Col.users, {'uid': operatorId});

  double _avg(Iterable<double> values) {
    final list = values.toList();
    return list.isEmpty ? 0 : list.reduce((x, y) => x + y) / list.length;
  }

  @override
  Future<SalaryWeightages> getWeightages() async {
    final snap = await _db
        .collection(Col.masterSalaryWeightages)
        .where('category', isEqualTo: 'frame_sheet')
        .get();
    final items = snap.docs.map(DocRow.fromSnapshot).toList();
    final d = AppConstants.defaultSalaryWeightages;
    if (items.isEmpty) {
      return SalaryWeightages(
        wA: d['wA']!, wB: d['wB']!, wC: d['wC']!,
        wD: d['wD']!, wE: d['wE']!, wF: d['wF']!,
      );
    }
    double val(String variable) =>
        items.where((w) => w.str('variable') == variable).firstOrNull?.real('percentage') ?? 0;
    double pick(String v) => val(v) > 0 ? val(v) : d[v]!;
    return SalaryWeightages(
      wA: pick('wA'), wB: pick('wB'), wC: pick('wC'),
      wD: pick('wD'), wE: pick('wE'), wF: pick('wF'),
    );
  }

  @override
  Future<Map<String, double>> getOperatorAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    final user = await _user(operatorId);
    if (user == null) {
      return {'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0};
    }
    final isFrame = user.strings('assignedMachines').any((m) => m.startsWith('Frame'));
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);

    Future<List<DocRow>> range(String collection) =>
        _reports.list(collection, startDate: start, endDate: end);

    final cleaning = await range(isFrame ? Col.frameCleaning : Col.sheetCleaning);
    final tools = await range(isFrame ? Col.frameToolsCount : Col.sheetToolsCount);
    final efficiency = await range(isFrame ? Col.frameProductionWeight : Col.sheetRunningFeet);
    final packing = await range(isFrame ? Col.frameShiftPacking : Col.sheetShiftPacking);
    final writing = await _reports.list(
      isFrame ? Col.frameWritingEfficiency : Col.sheetWritingEfficiency,
      equalsField: 'operatorId',
      equalsValue: operatorId,
      startDate: start,
      endDate: end,
    );

    final a = _avg(cleaning.map((r) => r.real('percentage')));
    final b = _avg(tools.map((r) => r.real('percentageAvailable')));
    final c = _avg(
      efficiency.where((r) => r.str('createdBy') == operatorId).map((r) => r.real('efficiencyPercentage')),
    );
    final d = _avg(packing.map((r) => r.real('qualityAcceptancePercentage')));
    final e = _avg(packing.map((r) => r.real('packingEfficiency')));
    final f = writing.isEmpty ? 0.0 : _avg(writing.map((r) => r.integer('score').toDouble())) / 5 * 100;
    return {'a': a, 'b': b, 'c': c, 'd': d, 'e': e, 'f': f};
  }

  @override
  Future<double> getFixedSalary(String operatorId) async =>
      (await _user(operatorId))?.real('fixedSalary') ?? 0;

  @override
  Future<String> getOperatorName(String operatorId) async =>
      (await _user(operatorId))?.str('name') ?? 'Unknown';

  @override
  Future<void> saveSalaryCalculation(SalaryCalculation calc) async {
    await _reports.add(Col.salaryCalculations, {
      'operatorId': calc.operatorId,
      'operatorName': calc.operatorName,
      'year': calc.year,
      'month': calc.month,
      'a': calc.a, 'b': calc.b, 'c': calc.c, 'd': calc.d, 'e': calc.e, 'f': calc.f,
      'wA': calc.wA, 'wB': calc.wB, 'wC': calc.wC, 'wD': calc.wD, 'wE': calc.wE, 'wF': calc.wF,
      'multiplier': calc.multiplier,
      'fixedSalary': calc.fixedSalary,
      'calculatedSalary': calc.calculatedSalary,
    });
  }

  SalaryCalculation _calc(DocRow s) => SalaryCalculation(
    id: s.id,
    operatorId: s.str('operatorId'),
    operatorName: s.str('operatorName'),
    year: s.integer('year'),
    month: s.integer('month'),
    a: s.real('a'), b: s.real('b'), c: s.real('c'),
    d: s.real('d'), e: s.real('e'), f: s.real('f'),
    wA: s.real('wA'), wB: s.real('wB'), wC: s.real('wC'),
    wD: s.real('wD'), wE: s.real('wE'), wF: s.real('wF'),
    multiplier: s.real('multiplier'),
    fixedSalary: s.real('fixedSalary'),
    calculatedSalary: s.real('calculatedSalary'),
  );

  @override
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) async {
    final row = await _reports.findOne(Col.salaryCalculations, {
      'operatorId': operatorId,
      'year': year,
      'month': month,
    });
    return row == null ? null : _calc(row);
  }

  @override
  Future<List<SalaryCalculation>> getCalculationsForMonth(int year, int month) async {
    final snap = await _db
        .collection(Col.salaryCalculations)
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    final list = snap.docs.map((d) => _calc(DocRow.fromSnapshot(d))).toList()
      ..sort((x, y) => x.operatorName.compareTo(y.operatorName));
    return list;
  }
}
```
Note: the date-range `list` here has no equality filter, so it uses the automatic single-field index; sorting for the month list is done in Dart to avoid another composite index.

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/salary/salary_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/salary/data/datasources test/features/salary/salary_remote_datasource_test.dart
git commit -m "feat(salary): move salary calculations to Firestore"
```

---

### Task 10: Dashboard datasource (reads counters, bounded queries)

**Files:**
- Rewrite: `lib/features/dashboard/data/datasources/dashboard_remote_datasource.dart`
- Test: `test/features/dashboard/dashboard_remote_datasource_test.dart`

**Interfaces:**
- Consumes: `Reports`, `StockLedger.read`, `Col`.
- Produces: `DashboardRemoteDatasource({required FirebaseFirestore firestore})`; `getDashboardSummary() → Future<DashboardSummary>` returns the same shape as today.

Changes vs. the old code: one week-range query per production collection (today's totals are derived from it instead of a second query); stock figures come from `StockLedger.read` (2 queries per kind) instead of scanning all history.

- [ ] **Step 1: Write the failing test**

`test/features/dashboard/dashboard_remote_datasource_test.dart`:
```dart
import 'package:factory_app/core/data/firestore_support.dart';
import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:factory_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('summary combines bounded queries and stock counters', () async {
    final db = FakeFirebaseFirestore();
    final today = DateTime.now();
    final todayKey = dateKey(today);
    final threeDaysAgo = dateKey(today.subtract(const Duration(days: 3)));
    final longAgo = dateKey(today.subtract(const Duration(days: 40)));

    await db.doc('users/a').set({'uid': '1', 'isActive': true});
    await db.doc('users/b').set({'uid': '2', 'isActive': false});

    await db.collection('frame_health_reports').add({'date': todayKey});
    await db.collection('sheet_health_reports').add({'date': todayKey});
    await db.collection('sheet_health_reports').add({'date': longAgo});

    await db.collection('frame_production_details_reports').add({'date': todayKey, 'totalWeight': 50.0});
    await db.collection('frame_production_details_reports').add({'date': threeDaysAgo, 'totalWeight': 30.0});
    await db.collection('frame_production_details_reports').add({'date': longAgo, 'totalWeight': 999.0});
    await db.collection('sheet_production_details_reports').add({'date': todayKey, 'totalRunningFeet': 70.0});

    await db.collection('frame_production_weight_reports').add({'date': todayKey, 'efficiencyPercentage': 80.0});
    await db.collection('frame_production_weight_reports').add({'date': threeDaysAgo, 'efficiencyPercentage': 60.0});
    await db.collection('sheet_running_feet_reports').add({'date': todayKey, 'efficiencyPercentage': 90.0});

    final batch = db.batch();
    StockLedger.apply(batch, db, kind: StockKind.frame, producedAmount: 100, lines: const [
      StockLine(variant: '3x2', density: '0.8', color: 'White', produced: 10, packed: 4, rejected: 1,
          packedAmount: 20, rejectedAmount: 5),
      StockLine(variant: '4x2', density: '0.8', color: 'White', produced: 5, packed: 5),
    ]);
    await batch.commit();

    final s = await DashboardRemoteDatasource(firestore: db).getDashboardSummary();
    expect(s.totalOperators, 2);
    expect(s.activeOperators, 1);
    expect(s.pendingApprovals, 2);
    expect(s.todayFrameWeight, 50);
    expect(s.todaySheetRunningFeet, 70);
    expect(s.weeklyFrameProduction.map((d) => d.value).toList()..sort(), [30, 50]);
    expect(s.avgFrameEfficiency, 70);
    expect(s.avgSheetEfficiency, 90);
    expect(s.frameStock.totalProduced, 100);
    expect(s.frameStock.totalPacked, 20);
    expect(s.frameStock.totalRejected, 5);
    expect(s.frameStock.stockInPlace, 75);
    // 4x2 is fully packed (inStock == 0) so it is filtered out of the breakdown.
    expect(s.frameStock.breakdown.single.variant, '3x2');
    expect(s.frameStock.breakdown.single.inStock, 5);
    expect(s.sheetStock.totalProduced, 0);
  });
}
```

- [ ] **Step 2: Run to verify failure**

Run: `flutter test test/features/dashboard/dashboard_remote_datasource_test.dart`
Expected: FAIL — no `firestore` parameter.

- [ ] **Step 3: Implement**

Replace the file:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../../core/data/stock_ledger.dart';
import '../../domain/entities/dashboard_entities.dart';

class DashboardRemoteDatasource {
  DashboardRemoteDatasource({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<DashboardSummary> getDashboardSummary() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekAgo = todayStart.subtract(const Duration(days: 7));

    // Operators
    final users = (await _db.collection(Col.users).get()).docs
        .map(DocRow.fromSnapshot)
        .toList();
    final totalOps = users.length;
    final activeOps = users.where((u) => u.flag('isActive')).length;

    // Reports submitted today (frame + sheet health)
    final frameHealth = await _reports.list(Col.frameHealth, startDate: todayStart);
    final sheetHealth = await _reports.list(Col.sheetHealth, startDate: todayStart);
    final pendingCount = frameHealth.length + sheetHealth.length;

    // One week-range query per production collection; "today" is a subset.
    final weekFrame = await _reports.list(Col.frameProductionDetails, startDate: weekAgo);
    final weekSheet = await _reports.list(Col.sheetProductionDetails, startDate: weekAgo);

    bool isToday(DocRow r) => !r.date('date').isBefore(todayStart);
    final todayFrameWeight = weekFrame
        .where(isToday)
        .fold<double>(0, (s, r) => s + r.real('totalWeight'));
    final todaySheetFeet = weekSheet
        .where(isToday)
        .fold<double>(0, (s, r) => s + r.real('totalRunningFeet'));

    Map<String, double> byDay(List<DocRow> rows, String field) {
      final out = <String, double>{};
      for (final r in rows) {
        final d = r.date('date');
        final key = '${d.year}-${d.month}-${d.day}';
        out[key] = (out[key] ?? 0) + r.real(field);
      }
      return out;
    }

    List<DailyProduction> toDailyList(Map<String, double> byDay) {
      return byDay.entries.map((e) {
        final parts = e.key.split('-').map(int.parse).toList();
        return DailyProduction(
          date: DateTime(parts[0], parts[1], parts[2]),
          value: e.value,
        );
      }).toList()..sort((a, b) => a.date.compareTo(b.date));
    }

    final frameStock = await _stock(StockKind.frame);
    final sheetStock = await _stock(StockKind.sheet);

    double avg(List<DocRow> rows) => rows.isEmpty
        ? 0.0
        : rows.map((r) => r.real('efficiencyPercentage')).reduce((a, b) => a + b) /
              rows.length;
    final avgFrameEff = avg(await _reports.list(Col.frameProductionWeight, startDate: weekAgo));
    final avgSheetEff = avg(await _reports.list(Col.sheetRunningFeet, startDate: weekAgo));

    return DashboardSummary(
      totalOperators: totalOps,
      activeOperators: activeOps,
      pendingApprovals: pendingCount,
      todayFrameWeight: todayFrameWeight,
      todaySheetRunningFeet: todaySheetFeet,
      avgFrameEfficiency: avgFrameEff,
      avgSheetEfficiency: avgSheetEff,
      weeklyFrameProduction: toDailyList(byDay(weekFrame, 'totalWeight')),
      weeklySheetProduction: toDailyList(byDay(weekSheet, 'totalRunningFeet')),
      frameStock: frameStock,
      sheetStock: sheetStock,
    );
  }

  Future<StockSummary> _stock(String kind) async {
    final data = await StockLedger.read(_db, kind);
    final breakdown = data.variants
        .map(
          (v) => StockLineItem(
            variant: v.variant,
            density: v.density,
            color: v.color,
            produced: v.produced,
            packed: v.packed,
            rejected: v.rejected,
          ),
        )
        .where((item) => item.inStock != 0)
        .toList()
      ..sort((a, b) => b.inStock.compareTo(a.inStock));
    return StockSummary(
      totalProduced: data.totalProduced,
      totalPacked: data.totalPacked,
      totalRejected: data.totalRejected,
      stockInPlace: data.totalProduced - data.totalPacked - data.totalRejected,
      breakdown: breakdown,
    );
  }
}
```

- [ ] **Step 4: Run tests**

Run: `flutter test test/features/dashboard/dashboard_remote_datasource_test.dart`
Expected: `All tests passed!`

- [ ] **Step 5: Commit**

```bash
git add lib/features/dashboard/data/datasources test/features/dashboard/dashboard_remote_datasource_test.dart
git commit -m "feat(dashboard): read stock counters and bounded week queries"
```

---

### Task 11: Wiring — DI, main, seeder, admin panel

**Files:**
- Modify: `lib/core/di/injection.dart`, `lib/main.dart`, `lib/features/admin/presentation/pages/admin_panel_page.dart`
- Rewrite: `lib/core/utils/master_table_seeder.dart`

**Interfaces:**
- Consumes: all new datasource constructors.
- Produces: `MasterTableSeeder.seed(AdminRemoteDatasource ds) → Future<String>` (returns `'Inserted: N, Skipped (duplicates): M'`).

- [ ] **Step 1: Update `lib/core/di/injection.dart`**

Replace the `generated/dataconnect/default.dart` import with:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/admin/data/datasources/user_account_creator.dart';
```
In `initDependencies`, replace `sl.registerLazySingleton(() => DefaultConnector.instance);` with:
```dart
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<UserAccountCreator>(() => SecondaryAppAccountCreator());
```
and replace the data-source registrations with:
```dart
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<FrameRemoteDataSource>(
    () => FrameRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<SheetRemoteDataSource>(
    () => SheetRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<SalaryRemoteDataSource>(
    () => SalaryRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton(
    () => AdminRemoteDatasource(firestore: sl(), accounts: sl()),
  );
  sl.registerLazySingleton(() => DashboardRemoteDatasource(firestore: sl()));
  sl.registerLazySingleton<ScrapRegrindRemoteDataSource>(
    () => ScrapRegrindRemoteDataSourceImpl(firestore: sl()),
  );
```
Leave the `SharedPreferences` registration if anything else uses it (`rg "SharedPreferences" lib` — if only `auth_remote_datasource` used it, remove the registration and the `shared_preferences` imports there; otherwise keep).

- [ ] **Step 2: Update `lib/main.dart`**

Add `import 'package:cloud_firestore/cloud_firestore.dart';` and, after `FirebaseAppCheck…activate(...)` and before `await initDependencies();`:
```dart
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
```
(Offline persistence cuts repeat reads against the free quota.)

- [ ] **Step 3: Rewrite the seeder**

`lib/core/utils/master_table_seeder.dart`:
```dart
import '../../features/admin/data/datasources/admin_remote_datasource.dart';
import '../../features/admin/domain/entities/admin_entities.dart';
import '../constants/app_constants.dart';

/// Seeds all master tables with data from [AppConstants].
/// Safe to run multiple times — duplicates are skipped.
class MasterTableSeeder {
  MasterTableSeeder._();

  static Future<String> seed(AdminRemoteDatasource ds) async {
    var inserted = 0;
    var skipped = 0;

    Future<void> run(Future<void> Function() fn) async {
      try {
        await fn();
        inserted++;
      } catch (_) {
        skipped++;
      }
    }

    Future<void> items(
      MasterTableType type,
      Iterable<String> values, {
      String? itemType,
      String Function(String)? displayName,
    }) async {
      var order = 0;
      for (final v in values) {
        await run(
          () => ds.insertMasterItem(
            type,
            MasterTableItem(
              id: '',
              value: v,
              type: itemType,
              displayName: displayName?.call(v),
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }

    // ── Machines (one running sort order across kinds) ──
    var order = 0;
    for (final entry in [
      ('frame', AppConstants.frameMachines),
      ('sheet', AppConstants.sheetMachines),
      ('scrap', AppConstants.scrapAllMachines),
    ]) {
      for (final m in entry.$2) {
        await run(
          () => ds.insertMasterItem(
            MasterTableType.machines,
            MasterTableItem(
              id: '',
              value: m,
              type: entry.$1,
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }

    await items(MasterTableType.shifts, AppConstants.shifts);
    await items(
      MasterTableType.roles,
      AppConstants.allRoles,
      displayName: (c) => AppConstants.roleDisplayNames[c] ?? c,
    );
    await items(MasterTableType.frameSections, AppConstants.defaultFrameSections);
    await items(MasterTableType.frameDensities, AppConstants.defaultFrameDensities);
    await items(MasterTableType.frameColors, AppConstants.defaultFrameColors);
    await items(MasterTableType.sheetThicknesses, AppConstants.defaultSheetThicknesses);
    await items(MasterTableType.sheetDensities, AppConstants.defaultSheetDensities);
    await items(MasterTableType.sheetColors, AppConstants.defaultSheetColors);

    // Maintenance items share one table; frame and scrap rows keep one running order.
    order = 0;
    for (final entry in [
      ('frame', AppConstants.defaultMaintenanceItems),
      ('scrap', AppConstants.scrapMaintenanceItems),
    ]) {
      for (final v in entry.$2) {
        await run(
          () => ds.insertMasterItem(
            MasterTableType.maintenanceItems,
            MasterTableItem(
              id: '',
              value: v,
              type: entry.$1,
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }
    await items(MasterTableType.scrapProducts, AppConstants.scrapProducts);

    // ── Lookup tables ──
    for (final section in AppConstants.defaultFrameWeights.entries) {
      for (final density in section.value.entries) {
        await run(
          () => ds.insertWeightEntry(
            MasterLookupType.frameWeights,
            MasterWeightEntry(id: '', key1: section.key, key2: density.key, weight: density.value),
          ),
        );
      }
    }
    for (final thickness in AppConstants.defaultSheetWeights.entries) {
      for (final density in thickness.value.entries) {
        await run(
          () => ds.insertWeightEntry(
            MasterLookupType.sheetWeights,
            MasterWeightEntry(id: '', key1: thickness.key, key2: density.key, weight: density.value),
          ),
        );
      }
    }
    for (final section in AppConstants.defaultFrameTargets.entries) {
      for (final density in section.value.entries) {
        await run(
          () => ds.insertTargetEntry(
            MasterLookupType.frameTargets,
            MasterTargetEntry(id: '', key: section.key, density: density.key, target: density.value),
          ),
        );
      }
    }
    for (final thickness in AppConstants.defaultSheetTargets.entries) {
      for (final density in thickness.value.entries) {
        await run(
          () => ds.insertTargetEntry(
            MasterLookupType.sheetTargets,
            MasterTargetEntry(id: '', key: thickness.key, density: density.key, target: density.value),
          ),
        );
      }
    }
    for (final entry in AppConstants.scrapTargetWeightPerHour.entries) {
      await run(
        () => ds.insertTargetEntry(
          MasterLookupType.scrapTargets,
          MasterTargetEntry(id: '', key: entry.key, target: entry.value),
        ),
      );
    }

    // ── Salary weightages ──
    const salaryLabels = {
      'wA': 'Machine Cleaning',
      'wB': 'Tools Count',
      'wC': 'Machine Health',
      'wD': 'Production Efficiency',
      'wE': 'Report Writing',
      'wF': 'Quality / Packing',
    };
    final existing = {
      'frame_sheet': (await ds.getSalaryWeightages()).map((e) => e.variable).toSet(),
      'scrap': (await ds.getSalaryWeightages(category: 'scrap')).map((e) => e.variable).toSet(),
    };
    Future<void> weightage(String category, String variable, String label, double pct) async {
      if (existing[category]!.contains(variable)) {
        skipped++;
        return;
      }
      await run(
        () => ds.insertSalaryWeightage(
          MasterSalaryWeightageEntry(
            id: '', variable: variable, label: label, category: category, percentage: pct,
          ),
        ),
      );
    }

    for (final e in AppConstants.defaultSalaryWeightages.entries) {
      await weightage('frame_sheet', e.key, salaryLabels[e.key] ?? e.key, e.value);
    }
    const scrapSalary = {'wA': 15.0, 'wB': 10.0, 'wE': 30.0, 'wF': 20.0, 'wG': 25.0};
    const scrapLabels = {
      'wA': 'Machine Cleaning %',
      'wB': 'Tools Count %',
      'wE': 'Production Efficiency %',
      'wF': 'Report Writing Efficiency %',
      'wG': 'Scrap Quality Rating %',
    };
    for (final e in scrapSalary.entries) {
      await weightage('scrap', e.key, scrapLabels[e.key] ?? e.key, e.value);
    }

    return 'Inserted: $inserted, Skipped (duplicates): $skipped';
  }
}
```
(Salary weightages have no uniqueness in Firestore, so the seeder checks existing variables first; the old DB had no unique constraint there either but also no automatic dedupe.)

- [ ] **Step 4: Update `admin_panel_page.dart`**

In `_seedMasterTables`, change `await MasterTableSeeder.seed();` to `await MasterTableSeeder.seed(sl<AdminRemoteDatasource>());` and add imports for `../../../../core/di/injection.dart` and `../../data/datasources/admin_remote_datasource.dart` (use the same relative style as the file's other imports).

- [ ] **Step 5: Analyse and run the unit suite**

Run: `flutter analyze lib test`
Expected: no errors referencing the migrated files. Remaining errors should only come from `lib/core/utils/seed_data.dart` and `lib/generated/**` (deleted in Task 13) — if any other file fails, fix it now.
Run: `flutter test test`
Expected: all tests pass except `test/integration/seed_database_test.dart` and `test/integration/migrate_master_tables_test.dart` (these import the generated connector; they are deleted in Task 13).

- [ ] **Step 6: Commit**

```bash
git add lib test
git commit -m "feat: wire Firestore/Auth datasources into DI and seeder"
```

---

### Task 12: Migration script (Postgres → Firestore + Auth)

**Files:**
- Create: `tools/migrate/package.json`, `.gitignore`, `config.js`, `transform.js`, `schema.js`, `stock.js`, `index.js`, `README.md`, `test/transform.test.js`, `test/stock.test.js`, `test/schema.test.js`

**Interfaces:**
- Produces CLI: `node index.js [--dry-run] [--verify-only]` with env `DATABASE_URL` and `GOOGLE_CLOUD_PROJECT=prabitha-operations`. Exit code 1 on any validation or count mismatch.

- [ ] **Step 1: Scaffold**

`tools/migrate/package.json`:
```json
{
  "name": "factory-app-migrate",
  "private": true,
  "scripts": { "test": "node --test test/", "migrate": "node index.js" },
  "dependencies": { "firebase-admin": "^12.1.0", "pg": "^8.11.5" }
}
```
`tools/migrate/.gitignore`: `node_modules`

Run: `cd tools/migrate && npm install`

- [ ] **Step 2: Write the failing tests**

`test/transform.test.js`:
```js
const { test } = require('node:test');
const assert = require('node:assert');
const { snakeToCamel, normalizePhone, emailFor, passwordFor, convertRow, slug } = require('../transform');

test('snakeToCamel', () => {
  assert.equal(snakeToCamel('machine_number'), 'machineNumber');
  assert.equal(snakeToCamel('w_a'), 'wA');
  assert.equal(snakeToCamel('total_running_feet'), 'totalRunningFeet');
  assert.equal(snakeToCamel('a'), 'a');
});

test('phone/email/password match the Dart AuthIdentity', () => {
  assert.equal(normalizePhone('9876543210'), '+919876543210');
  assert.equal(normalizePhone(' +919876543210 '), '+919876543210');
  assert.equal(emailFor('9876543210'), '919876543210@prabitha.app');
  assert.equal(passwordFor('1234'), 'prb#1234');
});

test('convertRow camelCases, drops id and listed columns, converts Dates', () => {
  const d = new Date('2026-11-10T08:00:00Z');
  const out = convertRow(
    { id: 'x', report_id: 'p', machine_number: 'M1', submitted_at: d, quantity: 3, tags: ['a'] },
    { drop: ['report_id'], toTimestamp: (v) => ({ ts: v.toISOString() }) },
  );
  assert.deepEqual(out, {
    machineNumber: 'M1', submittedAt: { ts: '2026-11-10T08:00:00.000Z' }, quantity: 3, tags: ['a'],
  });
});

test('slug matches Dart StockLedger._slug', () => {
  assert.equal(slug('3x2 "A"'), '3x2_A_');
  assert.equal(slug('0.8'), '0_8');
});
```
`test/stock.test.js`:
```js
const { test } = require('node:test');
const assert = require('node:assert');
const { buildStock } = require('../stock');

test('frame stock matches Dart StockLedger semantics', () => {
  const production = [
    { totalWeight: 50, lineItems: [{ section: '3x2', density: '0.8', color: 'White', quantity: 10 }] },
  ];
  const packing = [
    { lineItems: [{ section: '3x2', density: '0.8', color: 'White', packed: 6, rejectedQuality: 1, perPieceWeight: 5 }] },
  ];
  const { totals, variants } = buildStock('frame', production, packing);
  assert.deepEqual(totals, { totalProduced: 50, totalPacked: 30, totalRejected: 5 });
  assert.equal(variants.length, 1);
  assert.deepEqual(variants[0], {
    id: 'frame__3x2__0_8__White', kind: 'frame', variant: '3x2', density: '0.8', color: 'White',
    produced: 10, packed: 6, rejected: 1,
  });
});

test('sheet stock uses thickness, running feet and runningFeetPerItem', () => {
  const production = [
    { totalRunningFeet: 100, lineItems: [{ thickness: '9mm', density: 'D', color: 'C', quantity: 10 }] },
  ];
  const packing = [
    { lineItems: [{ thickness: '9mm', density: 'D', color: 'C', packed: 6, rejectedQuality: 1, runningFeetPerItem: 10 }] },
  ];
  const { totals, variants } = buildStock('sheet', production, packing);
  assert.deepEqual(totals, { totalProduced: 100, totalPacked: 60, totalRejected: 10 });
  assert.equal(variants[0].variant, '9mm');
});
```
`test/schema.test.js`:
```js
const { test } = require('node:test');
const assert = require('node:assert');
const { parseSchema, missingFields } = require('../schema');

const gql = `
type FrameCleaningReport @table {
  date: Date!
  machineNumber: String!
  percentage: Float!
  createdBy: String!
  timestamp: Timestamp @default(expr: "request.time")
}
type FrameMaintenanceEntry @table {
  report: FrameHealthReport!
  maintenanceItem: String!
  durationHours: Float!
}
`;

test('parseSchema lists required scalar fields and skips relations and optional fields', () => {
  const s = parseSchema(gql);
  assert.deepEqual(s.FrameCleaningReport.required, ['date', 'machineNumber', 'percentage', 'createdBy']);
  assert.deepEqual(s.FrameMaintenanceEntry.required, ['maintenanceItem', 'durationHours']);
});

test('missingFields reports absent or null required fields', () => {
  const s = parseSchema(gql);
  assert.deepEqual(missingFields(s, 'FrameCleaningReport', { date: '2026-11-01', machineNumber: 'M', percentage: 1, createdBy: null }), ['createdBy']);
});
```

- [ ] **Step 3: Run to verify failure**

Run: `cd tools/migrate && npm test`
Expected: FAIL — `Cannot find module '../transform'`.

- [ ] **Step 4: Implement modules**

`transform.js`:
```js
'use strict';

const slug = (s) => String(s).replace(/[^A-Za-z0-9]+/g, '_');

const snakeToCamel = (s) => s.replace(/_([a-z0-9])/g, (_, c) => c.toUpperCase());

// Keep in sync with lib/features/auth/data/auth_identity.dart
function normalizePhone(phone) {
  const t = String(phone ?? '').trim();
  if (t.startsWith('+')) return t;
  if (t.length === 10) return `+91${t}`;
  return t;
}
const emailFor = (phone) => `${normalizePhone(phone).replace(/[^0-9]/g, '')}@prabitha.app`;
const passwordFor = (raw) => `prb#${raw}`;

/**
 * Convert a Postgres row to a Firestore document body.
 * - snake_case columns -> camelCase fields
 * - `id` and any column in opts.drop are removed
 * - JS Dates (timestamptz) go through opts.toTimestamp
 * DATE columns must already be strings (see the pg type parser in index.js).
 */
function convertRow(row, opts = {}) {
  const drop = opts.drop || [];
  const toTimestamp = opts.toTimestamp || ((d) => d);
  const out = {};
  for (const [key, value] of Object.entries(row)) {
    if (key === 'id' || drop.includes(key)) continue;
    out[snakeToCamel(key)] = value instanceof Date ? toTimestamp(value) : value;
  }
  return out;
}

module.exports = { slug, snakeToCamel, normalizePhone, emailFor, passwordFor, convertRow };
```

`stock.js`:
```js
'use strict';
const { slug } = require('./transform');

/**
 * Rebuild stock counters from migrated production/packing documents.
 * Mirrors lib/core/data/stock_ledger.dart and the frame/sheet datasources.
 */
function buildStock(kind, productionDocs, packingDocs) {
  const frame = kind === 'frame';
  const variantKey = frame ? 'section' : 'thickness';
  const producedField = frame ? 'totalWeight' : 'totalRunningFeet';
  const perItemField = frame ? 'perPieceWeight' : 'runningFeetPerItem';

  const totals = { totalProduced: 0, totalPacked: 0, totalRejected: 0 };
  const variants = new Map();
  const variantFor = (li) => {
    const id = `${kind}__${slug(li[variantKey])}__${slug(li.density)}__${slug(li.color)}`;
    if (!variants.has(id)) {
      variants.set(id, {
        id, kind, variant: li[variantKey], density: li.density, color: li.color,
        produced: 0, packed: 0, rejected: 0,
      });
    }
    return variants.get(id);
  };

  for (const doc of productionDocs) {
    totals.totalProduced += doc[producedField] || 0;
    for (const li of doc.lineItems || []) variantFor(li).produced += li.quantity || 0;
  }
  for (const doc of packingDocs) {
    for (const li of doc.lineItems || []) {
      const v = variantFor(li);
      v.packed += li.packed || 0;
      v.rejected += li.rejectedQuality || 0;
      totals.totalPacked += (li.packed || 0) * (li[perItemField] || 0);
      totals.totalRejected += (li.rejectedQuality || 0) * (li[perItemField] || 0);
    }
  }
  return { totals, variants: [...variants.values()] };
}

module.exports = { buildStock };
```

`schema.js`:
```js
'use strict';

/** Parse `type X @table { ... }` blocks of schema.gql into required scalar fields. */
function parseSchema(gql) {
  const out = {};
  const typeRe = /type\s+(\w+)\s+@table\s*\{([\s\S]*?)\n\}/g;
  let m;
  while ((m = typeRe.exec(gql))) {
    const required = [];
    const all = [];
    for (const line of m[2].split('\n')) {
      const f = line.trim().match(/^(\w+):\s*(\[?\w+!?\]?!?)/);
      if (!f) continue;
      const [, name, type] = f;
      const isRelation = /^[A-Z]/.test(type.replace(/[\[\]!]/g, '')) &&
        !['String', 'Int', 'Float', 'Boolean', 'Date', 'Timestamp', 'UUID'].includes(type.replace(/[\[\]!]/g, ''));
      if (isRelation) continue;
      all.push(name);
      if (type.endsWith('!') && !/@default/.test(line)) required.push(name);
    }
    out[m[1]] = { required, all };
  }
  return out;
}

function missingFields(schema, typeName, doc) {
  const spec = schema[typeName];
  if (!spec) throw new Error(`Unknown schema type ${typeName}`);
  return spec.required.filter((f) => doc[f] === undefined || doc[f] === null);
}

module.exports = { parseSchema, missingFields };
```

`config.js`:
```js
'use strict';

// pg: Postgres table; col: Firestore collection; type: GraphQL type (schema.gql);
// children: child tables embedded into the parent under `key`, linked by a
// column that references the parent id (auto-detected: report_id or report).
const masters = [
  ['master_machine', 'master_machines', 'MasterMachine'],
  ['master_shift', 'master_shifts', 'MasterShift'],
  ['master_role', 'master_roles', 'MasterRole'],
  ['master_frame_section', 'master_frame_sections', 'MasterFrameSection'],
  ['master_frame_density', 'master_frame_densities', 'MasterFrameDensity'],
  ['master_frame_color', 'master_frame_colors', 'MasterFrameColor'],
  ['master_sheet_thickness', 'master_sheet_thicknesses', 'MasterSheetThickness'],
  ['master_sheet_density', 'master_sheet_densities', 'MasterSheetDensity'],
  ['master_sheet_color', 'master_sheet_colors', 'MasterSheetColor'],
  ['master_maintenance_item', 'master_maintenance_items', 'MasterMaintenanceItem'],
  ['master_scrap_product', 'master_scrap_products', 'MasterScrapProduct'],
  ['master_frame_weight', 'master_frame_weights', 'MasterFrameWeight'],
  ['master_sheet_weight', 'master_sheet_weights', 'MasterSheetWeight'],
  ['master_frame_target', 'master_frame_targets', 'MasterFrameTarget'],
  ['master_sheet_target', 'master_sheet_targets', 'MasterSheetTarget'],
  ['master_salary_weightage', 'master_salary_weightages', 'MasterSalaryWeightage'],
  ['master_scrap_target', 'master_scrap_targets', 'MasterScrapTarget'],
].map(([pg, col, type]) => ({ pg, col, type }));

const reports = [
  // frames
  { pg: 'frame_cleaning_report', col: 'frame_cleaning_reports', type: 'FrameCleaningReport' },
  { pg: 'frame_tools_count_report', col: 'frame_tools_count_reports', type: 'FrameToolsCountReport' },
  { pg: 'frame_health_report', col: 'frame_health_reports', type: 'FrameHealthReport',
    children: [{ pg: 'frame_maintenance_entry', key: 'entries', type: 'FrameMaintenanceEntry' }] },
  { pg: 'frame_production_details_report', col: 'frame_production_details_reports', type: 'FrameProductionDetailsReport',
    children: [{ pg: 'frame_production_line_item', key: 'lineItems', type: 'FrameProductionLineItem' }] },
  { pg: 'frame_production_weight_report', col: 'frame_production_weight_reports', type: 'FrameProductionWeightReport' },
  { pg: 'frame_shift_packing_report', col: 'frame_shift_packing_reports', type: 'FrameShiftPackingReport',
    children: [{ pg: 'frame_packing_line_item', key: 'lineItems', type: 'FramePackingLineItem' }] },
  { pg: 'frame_writing_efficiency', col: 'frame_writing_efficiencies', type: 'FrameWritingEfficiency' },
  { pg: 'frame_customer_rejection_report', col: 'frame_customer_rejection_reports', type: 'FrameCustomerRejectionReport',
    children: [{ pg: 'frame_customer_rejection_item', key: 'rejectedItems', type: 'FrameCustomerRejectionItem' }] },
  // sheets
  { pg: 'sheet_cleaning_report', col: 'sheet_cleaning_reports', type: 'SheetCleaningReport' },
  { pg: 'sheet_tools_count_report', col: 'sheet_tools_count_reports', type: 'SheetToolsCountReport' },
  { pg: 'sheet_health_report', col: 'sheet_health_reports', type: 'SheetHealthReport',
    children: [{ pg: 'sheet_maintenance_entry', key: 'entries', type: 'SheetMaintenanceEntry' }] },
  { pg: 'sheet_production_details_report', col: 'sheet_production_details_reports', type: 'SheetProductionDetailsReport',
    children: [{ pg: 'sheet_production_line_item', key: 'lineItems', type: 'SheetProductionLineItem' }] },
  { pg: 'sheet_running_feet_report', col: 'sheet_running_feet_reports', type: 'SheetRunningFeetReport' },
  { pg: 'sheet_shift_packing_report', col: 'sheet_shift_packing_reports', type: 'SheetShiftPackingReport',
    children: [{ pg: 'sheet_packing_line_item', key: 'lineItems', type: 'SheetPackingLineItem' }] },
  { pg: 'sheet_writing_efficiency', col: 'sheet_writing_efficiencies', type: 'SheetWritingEfficiency' },
  { pg: 'sheet_customer_rejection_report', col: 'sheet_customer_rejection_reports', type: 'SheetCustomerRejectionReport',
    children: [{ pg: 'sheet_customer_rejection_item', key: 'rejectedItems', type: 'SheetCustomerRejectionItem' }] },
  // scrap / regrind
  { pg: 'scrap_cleaning_report', col: 'scrap_cleaning_reports', type: 'ScrapCleaningReport' },
  { pg: 'scrap_tools_count_report', col: 'scrap_tools_count_reports', type: 'ScrapToolsCountReport' },
  { pg: 'scrap_machine_health_report', col: 'scrap_machine_health_reports', type: 'ScrapMachineHealthReport',
    children: [{ pg: 'scrap_maintenance_entry', key: 'entries', type: 'ScrapMaintenanceEntry' }] },
  { pg: 'scrap_production_details_report', col: 'scrap_production_details_reports', type: 'ScrapProductionDetailsReport',
    children: [{ pg: 'scrap_production_line_item', key: 'lineItems', type: 'ScrapProductionLineItem' }] },
  { pg: 'scrap_production_weight_report', col: 'scrap_production_weight_reports', type: 'ScrapProductionWeightReport' },
  { pg: 'scrap_writing_efficiency', col: 'scrap_writing_efficiencies', type: 'ScrapWritingEfficiency' },
  { pg: 'scrap_quality_report', col: 'scrap_quality_reports', type: 'ScrapQualityReport' },
  // salary
  { pg: 'salary_calculation', col: 'salary_calculations', type: 'SalaryCalculation' },
  { pg: 'scrap_salary_calculation', col: 'scrap_salary_calculations', type: 'ScrapSalaryCalculation' },
];

module.exports = { collections: [...masters, ...reports] };
```

`index.js`:
```js
'use strict';
const fs = require('node:fs');
const path = require('node:path');
const { Pool, types } = require('pg');
const admin = require('firebase-admin');

const { collections } = require('./config');
const { convertRow, normalizePhone, emailFor, passwordFor } = require('./transform');
const { parseSchema, missingFields } = require('./schema');
const { buildStock } = require('./stock');

const dryRun = process.argv.includes('--dry-run');
const verifyOnly = process.argv.includes('--verify-only');

// Keep DATE columns as 'yyyy-MM-dd' strings (the app's storage format).
types.setTypeParser(1082, (v) => v);

async function main() {
  if (!process.env.DATABASE_URL) throw new Error('Set DATABASE_URL');
  admin.initializeApp({ projectId: process.env.GOOGLE_CLOUD_PROJECT || 'prabitha-operations' });
  const db = admin.firestore();
  const auth = admin.auth();
  const pool = new Pool({ connectionString: process.env.DATABASE_URL });
  const schema = parseSchema(
    fs.readFileSync(path.join(__dirname, '../../dataconnect/schema/schema.gql'), 'utf8'),
  );
  const toTimestamp = (d) => admin.firestore.Timestamp.fromDate(d);
  const problems = [];
  const migrated = {}; // collection -> docs (for stock rebuild)

  const exists = async (table) =>
    (await pool.query('select to_regclass($1) as t', [`public."${table}"`])).rows[0].t !== null;
  const fkColumn = async (table) => {
    const r = await pool.query(
      `select column_name from information_schema.columns
       where table_schema='public' and table_name=$1 and column_name in ('report_id','report')`,
      [table],
    );
    if (!r.rows.length) throw new Error(`Cannot find parent FK column on ${table}`);
    return r.rows[0].column_name;
  };

  if (!verifyOnly) {
    const writer = db.bulkWriter();
    writer.onWriteError((e) => { problems.push(`write failed ${e.documentRef.path}: ${e.message}`); return false; });

    // ── users + Auth accounts ──
    if (await exists('user')) {
      const users = (await pool.query('select * from "user"')).rows;
      for (const u of users) {
        const phone = normalizePhone(u.phone);
        const email = emailFor(phone);
        let authUid;
        if (dryRun) authUid = `dry-${u.id}`;
        else {
          try {
            authUid = (await auth.createUser({ email, password: passwordFor(u.password), displayName: u.name })).uid;
          } catch (e) {
            if (e.code !== 'auth/email-already-exists') throw e;
            authUid = (await auth.getUserByEmail(email)).uid;
            await auth.updateUser(authUid, { password: passwordFor(u.password) });
          }
        }
        const body = convertRow(u, { drop: ['password'], toTimestamp });
        body.phone = phone;
        body.email = body.email || '';
        body.roles = u.roles || [];
        body.assignedMachines = u.assigned_machines || [];
        const missing = missingFields(schema, 'User', { ...body, password: 'x' });
        if (missing.length) problems.push(`users ${u.id}: missing ${missing.join(',')}`);
        if (!dryRun) writer.set(db.collection('users').doc(authUid), body);
      }
      console.log(`users: ${users.length}`);
    }

    // ── masters, reports (children embedded) ──
    for (const c of collections) {
      if (!(await exists(c.pg))) { console.warn(`skip (missing table): ${c.pg}`); continue; }
      const rows = (await pool.query(`select * from "${c.pg}"`)).rows;
      const childData = [];
      for (const ch of c.children || []) {
        const fk = await fkColumn(ch.pg);
        const crow = (await pool.query(`select * from "${ch.pg}"`)).rows;
        childData.push({ ...ch, fk, rows: crow });
      }
      migrated[c.col] = [];
      for (const r of rows) {
        const body = convertRow(r, { toTimestamp });
        for (const ch of childData) {
          const mine = ch.rows.filter((x) => x[ch.fk] === r.id);
          body[ch.key] = mine.map((x) => {
            const item = convertRow(x, { drop: [ch.fk], toTimestamp });
            const miss = missingFields(schema, ch.type, item);
            if (miss.length) problems.push(`${ch.pg} ${x.id}: missing ${miss.join(',')}`);
            return item;
          });
        }
        const miss = missingFields(schema, c.type, body);
        if (miss.length) problems.push(`${c.pg} ${r.id}: missing ${miss.join(',')}`);
        migrated[c.col].push(body);
        if (!dryRun) writer.set(db.collection(c.col).doc(r.id), body);
      }
      console.log(`${c.col}: ${rows.length}`);
    }

    // ── stock counters ──
    for (const [kind, prod, pack] of [
      ['frame', 'frame_production_details_reports', 'frame_shift_packing_reports'],
      ['sheet', 'sheet_production_details_reports', 'sheet_shift_packing_reports'],
    ]) {
      const { totals, variants } = buildStock(kind, migrated[prod] || [], migrated[pack] || []);
      console.log(`stock ${kind}:`, totals, `${variants.length} variants`);
      if (!dryRun) {
        writer.set(db.collection('stock_totals').doc(kind), totals);
        for (const v of variants) { const { id, ...rest } = v; writer.set(db.collection('stock_variants').doc(id), rest); }
      }
    }
    await writer.close();
  }

  // ── verification ──
  const checks = [{ pg: 'user', col: 'users' }, ...collections];
  for (const c of checks) {
    if (!(await exists(c.pg))) continue;
    const pgCount = Number((await pool.query(`select count(*) from "${c.pg}"`)).rows[0].count);
    const fsCount = (await db.collection(c.col).count().get()).data().count;
    const ok = dryRun ? true : pgCount === fsCount;
    console.log(`${ok ? 'OK ' : 'BAD'} ${c.col}: postgres=${pgCount} firestore=${fsCount}`);
    if (!ok) problems.push(`count mismatch ${c.col}: ${pgCount} vs ${fsCount}`);
  }

  await pool.end();
  if (problems.length) {
    console.error('\nPROBLEMS:\n' + problems.slice(0, 50).join('\n'));
    process.exit(1);
  }
  console.log(dryRun ? '\nDry run OK (nothing written).' : '\nMigration verified.');
}

main().catch((e) => { console.error(e); process.exit(1); });
```
`README.md`:
````markdown
# Postgres → Firestore migration

Copies the Data Connect (Cloud SQL) database into Firestore and Firebase Auth.
Passwords are used only to create Auth accounts and are never written to Firestore.

## Prerequisites
- Node 18+, `npm install` in this folder.
- `gcloud auth application-default login` (Owner/Editor on `prabitha-operations`).
- Firestore database and Email/Password sign-in enabled in the Firebase console.
- A `DATABASE_URL` for the source database, either:
  - live: start `cloud-sql-proxy <PROJECT:REGION:INSTANCE>` (find it with
    `gcloud sql instances list --project prabitha-operations`), then
    `postgres://postgres:<password>@127.0.0.1:5432/fdcdb`; or
  - rehearsal: `createdb fdcdb_rehearsal && psql fdcdb_rehearsal < ../sql/backup/2026-09-28/entire_sql_backup.sql`,
    then `postgres:///fdcdb_rehearsal`.

## Run
```bash
DATABASE_URL=… node index.js --dry-run      # reads, validates against schema.gql, writes nothing
DATABASE_URL=… node index.js                # migrates, then verifies counts
DATABASE_URL=… node index.js --verify-only  # compares row counts only
```
Re-running is safe: documents keep their Postgres UUIDs and Auth users are matched by email.
Exit code is 1 if validation or any count comparison fails.
````

- [ ] **Step 5: Run tests**

Run: `cd tools/migrate && npm test`
Expected: all tests pass (`# pass 8`, `# fail 0`).

- [ ] **Step 6: Rehearse against the backup**

```bash
createdb fdcdb_rehearsal && psql fdcdb_rehearsal < tools/sql/backup/2026-09-28/entire_sql_backup.sql
cd tools/migrate
DATABASE_URL=postgres:///fdcdb_rehearsal node index.js --dry-run
```
Expected: per-collection counts print, `Dry run OK`. The 2026-09-28 backup may use older table/column names than the live Data Connect database (e.g. `frame_health_rating_item` in `schema_ddl.sql`); a `missing:` problem line identifies exactly which table/column differs. For the **live** run the schema validation (`missingFields`) guarantees every required field from `schema.gql` is present, so a wrong assumption about column naming (e.g. `w_a`) fails loudly instead of migrating silently. Against the live DB, first confirm names with `psql … -c '\d frame_production_line_item'` and `-c '\d "user"'`; if the child FK column is not `report_id` or `report`, extend the `fkColumn` query.

- [ ] **Step 7: Commit**

```bash
git add tools/migrate
git commit -m "feat: add Postgres to Firestore migration script with verification"
```

---

### Task 13: Remove Data Connect and dead code

**Files:**
- Delete: `dataconnect/`, `lib/generated/dataconnect/`, `lib/core/utils/seed_data.dart`, `tools/seed_database.dart`, `tools/migrate_master_tables.dart`, `tools/insert_staff_users.exp`, `test/integration/seed_database_test.dart`, `test/integration/migrate_master_tables_test.dart`, `integration_test/migrate_master_tables_test.dart`
- Modify: `pubspec.yaml` (drop `firebase_data_connect`), `firebase.json` (drop the `dataconnect` key), `lib/core/config/dev_flags.dart` (remove the now-unused flag), `README.md` (if it mentions Data Connect/Cloud SQL)

- [ ] **Step 1: Delete**

```bash
git rm -r dataconnect lib/generated/dataconnect lib/core/utils/seed_data.dart \
  tools/seed_database.dart tools/migrate_master_tables.dart tools/insert_staff_users.exp \
  test/integration/seed_database_test.dart test/integration/migrate_master_tables_test.dart \
  integration_test/migrate_master_tables_test.dart
```
Keep `tools/sql/` (backups + reference SQL).

- [ ] **Step 2: Remove the dependency and flag**

`flutter pub remove firebase_data_connect`
In `firebase.json` delete the `"dataconnect":{"source":"dataconnect"},` entry (keep valid JSON: `python3 -c "import json;json.load(open('firebase.json'))"`).
In `lib/core/config/dev_flags.dart` delete `bypassPasswordCheck`; if the class is empty and unused, delete the file. Confirm: `rg "DevFlags|bypassPasswordCheck" lib test` returns nothing.

- [ ] **Step 3: Verify nothing references the old stack**

Run: `rg -n "dataconnect|DefaultConnector|firebase_data_connect|generated/dataconnect" lib test integration_test tools pubspec.yaml firebase.json --glob '!tools/sql/**'`
Expected: no matches.

- [ ] **Step 4: Full verification**

Run: `flutter analyze` → Expected: `No issues found!` (existing lints that predate this branch are acceptable; no new errors).
Run: `flutter test` → Expected: all tests pass.
Run: `flutter build apk --debug` → Expected: `✓ Built build/app/outputs/flutter-apk/app-debug.apk`.

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "chore: remove Data Connect, generated SDK and Cloud SQL tooling"
```

---

### Task 14: Cutover runbook and manual verification

**Files:**
- Create: `docs/superpowers/plans/2026-11-23-cutover-checklist.md` (copy of the checklist below, ticked as you go)

This task is performed with the user; nothing here is automated away.

- [ ] **Step 1: Deploy rules and indexes (needs the manual prerequisites)**

```bash
firebase deploy --only firestore:rules,firestore:indexes --project prabitha-operations
```
Expected: `Deploy complete!`. Index builds take a few minutes; check `firebase firestore:indexes` shows no `CREATING` entries before continuing.

- [ ] **Step 2: Rehearse the migration against a live export**

Start the Cloud SQL Auth Proxy to the Data Connect instance and run:
```bash
cd tools/migrate
DATABASE_URL='postgres://postgres:<password>@127.0.0.1:5432/fdcdb' node index.js --dry-run
```
Expected: `Dry run OK`. Fix any `missing:` problems (schema drift) before proceeding.

- [ ] **Step 3: Freeze writes and migrate**

Ask all operators to stop submitting (or do it outside shift hours). Then:
```bash
DATABASE_URL=… node index.js
DATABASE_URL=… node index.js --verify-only
```
Expected: every line `OK … postgres=N firestore=N`, final `Migration verified.`

- [ ] **Step 4: Smoke-test a debug build against production data**

Run `flutter run` and check, with a real operator and the admin account: login (phone + usual password), dashboard totals look right (compare with the old app/SQL: `select sum(total_weight) from frame_production_details_report`), submit one report of each family and see it in its list, delete a production report and confirm dashboard stock moves back, admin → create a test user and log in as them, rename a test master value and confirm weights follow, salary page loads for a frame, sheet and scrap operator.

- [ ] **Step 5: Watch the free quota for a week**

Firebase console → Firestore → Usage. If daily reads regularly exceed ~30K, add caching to the heaviest list screens or move the project to the Blaze plan (same free quota, pay only past it). Rotate/remove any temporary Cloud SQL `postgres` password once finished.

- [ ] **Step 6: Release and decommission**

Build and distribute the release (`flutter build apk --release` / the usual iOS flow). After one to two weeks of stable use: take a final SQL export into `tools/sql/backup/<date>/`, delete the Cloud SQL instance (Google Cloud console → SQL) and the Data Connect service (Firebase console → Data Connect), and confirm the billing page shows no Cloud SQL charges.

- [ ] **Step 7: Merge**

```bash
git checkout main && git merge --no-ff feat/firestore-migration
```
(Only after Step 4 passes on the branch.)

---

## Self-review

**Spec coverage:** collections/embedding/dates (Tasks 2, 6–10); query/quota handling and indexes (Tasks 2, 3, 10, 11 offline persistence); Auth + rules + admin account creation (Tasks 3, 4, 5); migration script with verification and Auth accounts without copying passwords (Task 12); cleanup (Task 13); testing with fake Firestore, rules emulator, migration unit tests and a manual smoke test (all tasks, Task 14); Cloud SQL shutdown (Task 14). Spec amendments are all covered: embedding (6–8, 12), stock counters (2, 6, 7, 10, 12), date strings (2), auth uid keying/prefix password (4, 5, 12), phone-change limitation (5), fake_cloud_firestore (all), rename in place (5).

**Known looseness to watch during execution:** Tasks 7 and 8 specify the sheet and scrap rewrites by a field table plus the complete worked example in Task 6, not by repeating ~1,400 lines of mapping code; their entity constructor argument names must be read from the old method bodies being replaced. Tests in Tasks 6–9 construct entities with the argument lists seen in the existing code; if a named parameter differs, adjust the test to the entity, never the reverse.

**Type consistency:** `DocRow`/`Reports`/`StockLedger`/`StockLine`/`StockKind`/`Col` names and signatures are identical across Tasks 2, 5–11; migration `buildStock` mirrors `StockLedger` slugging and arithmetic (verified by `slug` and `buildStock` tests).
