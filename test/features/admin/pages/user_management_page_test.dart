import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/features/admin/domain/entities/admin_entities.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:factory_app/features/admin/presentation/pages/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAdminRepository extends Mock implements AdminRepository {}

/// Staff seeded via SQL: phone stored with the +91 prefix, no fixed salary.
const _seniorOperator = ManagedUser(
  uid: '+919540257569',
  name: 'Sanjeev',
  phone: '+919540257569',
  roles: ['frames_senior_operator'],
  assignedMachines: [AppConstants.frameMachine1],
  fixedSalary: 0,
  isActive: true,
);

void main() {
  late _MockAdminRepository repository;

  setUpAll(() {
    registerFallbackValue(_seniorOperator);
  });

  setUp(() {
    repository = _MockAdminRepository();
    when(() => repository.getAllUsers()).thenAnswer((_) async => [
          _seniorOperator,
        ]);
    when(() => repository.updateUser(any())).thenAnswer((_) async {});
    sl.registerSingleton<DropdownConfigProvider>(
      DropdownConfigProvider(adminRepository: repository),
    );
  });

  tearDown(() => sl.reset());

  Future<void> pumpUserManagement(WidgetTester tester) async {
    await tester.pumpWidget(
      // The app provides AdminBloc above the navigator so pushed routes,
      // such as the user form, can reach it.
      BlocProvider(
        create: (_) => AdminBloc(repository)..add(LoadUsers()),
        child: const MaterialApp(home: UserManagementPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> openEditForm(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
  }

  testWidgets('edit form saves machine changes for a +91 phone user', (
    tester,
  ) async {
    await pumpUserManagement(tester);
    await openEditForm(tester);

    await tapVisible(
      tester,
      find.widgetWithText(FilterChip, AppConstants.sheetMachine3),
    );
    await tapVisible(tester, find.text('Update User'));

    final saved = verify(() => repository.updateUser(captureAny()))
        .captured
        .single as ManagedUser;
    expect(saved.assignedMachines, [
      AppConstants.frameMachine1,
      AppConstants.sheetMachine3,
    ]);
    expect(saved.phone, _seniorOperator.phone);
  });

  testWidgets('scrap machines can be assigned', (tester) async {
    await pumpUserManagement(tester);
    await openEditForm(tester);

    await tapVisible(
      tester,
      find.widgetWithText(FilterChip, AppConstants.crusherMachine1),
    );
    await tapVisible(tester, find.text('Update User'));

    final saved = verify(() => repository.updateUser(captureAny()))
        .captured
        .single as ManagedUser;
    expect(saved.assignedMachines, contains(AppConstants.crusherMachine1));
  });
}
