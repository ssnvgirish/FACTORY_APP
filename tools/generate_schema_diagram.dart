/// Generates a Mermaid ER diagram and a SQL DDL script from the app's
/// Firebase Data Connect schema (dataconnect/schema/schema.gql).
///
/// Usage:
///   dart run tools/generate_schema_diagram.dart
///
/// Outputs:
///   - tools/output/schema_er_diagram.md  (Mermaid ER diagram)
///   - tools/output/schema_ddl.sql        (PostgreSQL DDL)

import 'dart:io';

void main() {
  final schemaFile = File('dataconnect/schema/schema.gql');
  if (!schemaFile.existsSync()) {
    stderr.writeln('Error: dataconnect/schema/schema.gql not found.');
    stderr.writeln('Run this script from the project root.');
    exit(1);
  }

  final content = schemaFile.readAsStringSync();
  final tables = _parseSchema(content);

  final outputDir = Directory('tools/output');
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);

  // Generate Mermaid ER diagram
  final mermaid = _generateMermaid(tables);
  File('tools/output/schema_er_diagram.md').writeAsStringSync(mermaid);
  stdout.writeln('✓ Generated tools/output/schema_er_diagram.md');

  // Generate PostgreSQL DDL
  final ddl = _generateDDL(tables);
  File('tools/output/schema_ddl.sql').writeAsStringSync(ddl);
  stdout.writeln('✓ Generated tools/output/schema_ddl.sql');
}

// ─── Schema Parser ───────────────────────────────────────────────────────────

class TableDef {
  final String name;
  final List<FieldDef> fields;
  TableDef(this.name, this.fields);
}

class FieldDef {
  final String name;
  final String type;
  final bool required;
  final bool isUnique;
  final bool isList;
  final String? defaultExpr;
  final String? defaultValue;
  final String? relation; // FK reference table name

  FieldDef({
    required this.name,
    required this.type,
    required this.required,
    this.isUnique = false,
    this.isList = false,
    this.defaultExpr,
    this.defaultValue,
    this.relation,
  });
}

List<TableDef> _parseSchema(String content) {
  final tables = <TableDef>[];
  final typeRegex = RegExp(r'type\s+(\w+)\s+@table\s*\{([^}]+)\}');

  for (final match in typeRegex.allMatches(content)) {
    final name = match.group(1)!;
    final body = match.group(2)!;
    final fields = <FieldDef>[];

    for (final line in body.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

      final fieldMatch = RegExp(
        r'(\w+):\s+(\[?)(\w+!?)(\]?)(!?)\s*(.*)',
      ).firstMatch(trimmed);
      if (fieldMatch == null) continue;

      final fieldName = fieldMatch.group(1)!;
      var rawType = fieldMatch.group(3)!;
      final isList = fieldMatch.group(2) == '[' || fieldMatch.group(4) == ']';
      final trailingBang = fieldMatch.group(5) == '!';
      final directives = fieldMatch.group(6) ?? '';

      final typeRequired = rawType.endsWith('!');
      if (typeRequired) rawType = rawType.substring(0, rawType.length - 1);

      final required = typeRequired || trailingBang;
      final isUnique = directives.contains('@unique');

      String? defaultExpr;
      final exprMatch = RegExp(
        r'@default\(expr:\s*"([^"]+)"\)',
      ).firstMatch(directives);
      if (exprMatch != null) defaultExpr = exprMatch.group(1);

      String? defaultValue;
      final valMatch = RegExp(
        r'@default\(value:\s*(\w+)\)',
      ).firstMatch(directives);
      if (valMatch != null) defaultValue = valMatch.group(1);

      // Check if type is a relation (another table)
      String? relation;
      final knownScalars = {
        'String',
        'Int',
        'Float',
        'Boolean',
        'Date',
        'Timestamp',
      };
      if (!knownScalars.contains(rawType) && !isList) {
        relation = rawType;
        rawType = 'UUID'; // FK reference
      }

      fields.add(
        FieldDef(
          name: fieldName,
          type: rawType,
          required: required,
          isUnique: isUnique,
          isList: isList,
          defaultExpr: defaultExpr,
          defaultValue: defaultValue,
          relation: relation,
        ),
      );
    }

    tables.add(TableDef(name, fields));
  }

  return tables;
}

// ─── Mermaid Generator ───────────────────────────────────────────────────────

String _generateMermaid(List<TableDef> tables) {
  final buf = StringBuffer();
  buf.writeln('# Database Schema - ER Diagram');
  buf.writeln();
  buf.writeln('```mermaid');
  buf.writeln('erDiagram');

  // Relationships
  for (final table in tables) {
    for (final field in table.fields) {
      if (field.relation != null) {
        buf.writeln('    ${field.relation} ||--o{ ${table.name} : "has"');
      }
    }
  }

  buf.writeln();

  // Table definitions
  for (final table in tables) {
    buf.writeln('    ${table.name} {');
    // Add implicit PK
    buf.writeln('        UUID id PK');
    for (final field in table.fields) {
      final pgType = _gqlToMermaidType(field.type, field.isList);
      final constraint = field.isUnique
          ? 'UK'
          : field.relation != null
          ? 'FK'
          : '';
      buf.writeln('        $pgType ${field.name} ${constraint}'.trimRight());
    }
    buf.writeln('    }');
  }

  buf.writeln('```');
  return buf.toString();
}

String _gqlToMermaidType(String gqlType, bool isList) {
  if (isList) return 'JSONB';
  switch (gqlType) {
    case 'String':
      return 'TEXT';
    case 'Int':
      return 'INT';
    case 'Float':
      return 'FLOAT';
    case 'Boolean':
      return 'BOOLEAN';
    case 'Date':
      return 'DATE';
    case 'Timestamp':
      return 'TIMESTAMP';
    case 'UUID':
      return 'UUID';
    default:
      return 'TEXT';
  }
}

// ─── DDL Generator ───────────────────────────────────────────────────────────

String _generateDDL(List<TableDef> tables) {
  final buf = StringBuffer();
  buf.writeln(
    '-- Auto-generated PostgreSQL DDL from dataconnect/schema/schema.gql',
  );
  buf.writeln('-- Generated on: ${DateTime.now().toIso8601String()}');
  buf.writeln();

  for (final table in tables) {
    final sqlName = _toSnakeCase(table.name);
    buf.writeln('CREATE TABLE $sqlName (');
    buf.writeln('    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),');

    final lines = <String>[];
    for (final field in table.fields) {
      final colName = _toSnakeCase(field.name);
      final pgType = _gqlToPostgresType(field.type, field.isList);
      final nullable = field.required ? ' NOT NULL' : '';
      final unique = field.isUnique ? ' UNIQUE' : '';

      var defaultClause = '';
      if (field.defaultExpr == 'request.time') {
        defaultClause = ' DEFAULT NOW()';
      } else if (field.defaultValue != null) {
        defaultClause = ' DEFAULT ${field.defaultValue}';
      }

      var fkComment = '';
      if (field.relation != null) {
        fkComment = ' REFERENCES ${_toSnakeCase(field.relation!)}(id)';
      }

      lines.add('    $colName $pgType$nullable$unique$defaultClause$fkComment');
    }

    buf.writeln(lines.join(',\n'));
    buf.writeln(');');
    buf.writeln();
  }

  // Add useful indexes
  buf.writeln('-- ═══════════════════════════════════════');
  buf.writeln('-- Indexes');
  buf.writeln('-- ═══════════════════════════════════════');
  buf.writeln();
  for (final table in tables) {
    final sqlName = _toSnakeCase(table.name);
    final hasDate = table.fields.any((f) => f.name == 'date');
    final hasMachine = table.fields.any((f) => f.name == 'machineNumber');

    if (hasDate && hasMachine) {
      buf.writeln(
        'CREATE INDEX idx_${sqlName}_date_machine ON $sqlName(date, machine_number);',
      );
    } else if (hasDate) {
      buf.writeln('CREATE INDEX idx_${sqlName}_date ON $sqlName(date);');
    }

    final hasOperatorId = table.fields.any((f) => f.name == 'operatorId');
    if (hasOperatorId) {
      buf.writeln(
        'CREATE INDEX idx_${sqlName}_operator ON $sqlName(operator_id);',
      );
    }
  }

  return buf.toString();
}

String _gqlToPostgresType(String gqlType, bool isList) {
  if (isList) return 'JSONB';
  switch (gqlType) {
    case 'String':
      return 'TEXT';
    case 'Int':
      return 'INTEGER';
    case 'Float':
      return 'DOUBLE PRECISION';
    case 'Boolean':
      return 'BOOLEAN';
    case 'Date':
      return 'DATE';
    case 'Timestamp':
      return 'TIMESTAMPTZ';
    case 'UUID':
      return 'UUID';
    default:
      return 'TEXT';
  }
}

String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m[0]!.toLowerCase()}')
      .replaceFirst(RegExp(r'^_'), '');
}
