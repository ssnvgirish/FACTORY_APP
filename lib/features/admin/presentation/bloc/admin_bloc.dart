import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/admin_entities.dart';
import '../../domain/repositories/admin_repository.dart';

// ─── Events ───
abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class LoadUsers extends AdminEvent {}

class CreateUserRequested extends AdminEvent {
  final String name;
  final String phone;
  final String password;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;

  const CreateUserRequested({
    required this.name,
    required this.phone,
    required this.password,
    required this.roles,
    required this.assignedMachines,
    required this.fixedSalary,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    password,
    roles,
    assignedMachines,
    fixedSalary,
  ];
}

class UpdateUserRequested extends AdminEvent {
  final ManagedUser user;
  const UpdateUserRequested(this.user);
  @override
  List<Object?> get props => [user];
}

class ToggleUserActiveRequested extends AdminEvent {
  final String uid;
  final bool isActive;
  const ToggleUserActiveRequested(this.uid, this.isActive);
  @override
  List<Object?> get props => [uid, isActive];
}

// ── Master dropdown-table events ──

class LoadMasterTable extends AdminEvent {
  final MasterTableType tableType;
  const LoadMasterTable(this.tableType);
  @override
  List<Object?> get props => [tableType];
}

class InsertMasterItemRequested extends AdminEvent {
  final MasterTableType tableType;
  final MasterTableItem item;
  const InsertMasterItemRequested(this.tableType, this.item);
  @override
  List<Object?> get props => [tableType, item];
}

class UpdateMasterItemRequested extends AdminEvent {
  final MasterTableType tableType;
  final MasterTableItem item;
  const UpdateMasterItemRequested(this.tableType, this.item);
  @override
  List<Object?> get props => [tableType, item];
}

class DeleteMasterItemRequested extends AdminEvent {
  final MasterTableType tableType;
  final String id;
  const DeleteMasterItemRequested(this.tableType, this.id);
  @override
  List<Object?> get props => [tableType, id];
}

// ── Master lookup-table events ──

class LoadMasterLookup extends AdminEvent {
  final MasterLookupType lookupType;
  const LoadMasterLookup(this.lookupType);
  @override
  List<Object?> get props => [lookupType];
}

class SaveMasterWeightEntry extends AdminEvent {
  final MasterLookupType lookupType;
  final MasterWeightEntry entry;
  final bool isNew;
  const SaveMasterWeightEntry(
    this.lookupType,
    this.entry, {
    this.isNew = false,
  });
  @override
  List<Object?> get props => [lookupType, entry, isNew];
}

class DeleteMasterWeightEntry extends AdminEvent {
  final MasterLookupType lookupType;
  final String id;
  const DeleteMasterWeightEntry(this.lookupType, this.id);
  @override
  List<Object?> get props => [lookupType, id];
}

class SaveMasterTargetEntry extends AdminEvent {
  final MasterLookupType lookupType;
  final MasterTargetEntry entry;
  final bool isNew;
  const SaveMasterTargetEntry(
    this.lookupType,
    this.entry, {
    this.isNew = false,
  });
  @override
  List<Object?> get props => [lookupType, entry, isNew];
}

class DeleteMasterTargetEntry extends AdminEvent {
  final MasterLookupType lookupType;
  final String id;
  const DeleteMasterTargetEntry(this.lookupType, this.id);
  @override
  List<Object?> get props => [lookupType, id];
}

class LoadSalaryWeightages extends AdminEvent {
  final String category;
  const LoadSalaryWeightages({this.category = 'frame_sheet'});
  @override
  List<Object?> get props => [category];
}

class SaveSalaryWeightage extends AdminEvent {
  final MasterSalaryWeightageEntry entry;
  final bool isNew;
  const SaveSalaryWeightage(this.entry, {this.isNew = false});
  @override
  List<Object?> get props => [entry, isNew];
}

// ─── States ───
abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class UsersLoaded extends AdminState {
  final List<ManagedUser> users;
  const UsersLoaded(this.users);
  @override
  List<Object?> get props => [users];
}

class UserSaved extends AdminState {}

class MasterTableLoaded extends AdminState {
  final MasterTableType tableType;
  final List<MasterTableItem> items;
  const MasterTableLoaded(this.tableType, this.items);
  @override
  List<Object?> get props => [tableType, items];
}

class MasterItemSaved extends AdminState {
  final MasterTableType tableType;
  const MasterItemSaved(this.tableType);
  @override
  List<Object?> get props => [tableType];
}

class MasterWeightsLoaded extends AdminState {
  final MasterLookupType lookupType;
  final List<MasterWeightEntry> entries;
  const MasterWeightsLoaded(this.lookupType, this.entries);
  @override
  List<Object?> get props => [lookupType, entries];
}

class MasterTargetsLoaded extends AdminState {
  final MasterLookupType lookupType;
  final List<MasterTargetEntry> entries;
  const MasterTargetsLoaded(this.lookupType, this.entries);
  @override
  List<Object?> get props => [lookupType, entries];
}

class SalaryWeightagesLoaded extends AdminState {
  final List<MasterSalaryWeightageEntry> entries;
  const SalaryWeightagesLoaded(this.entries);
  @override
  List<Object?> get props => [entries];
}

class MasterLookupSaved extends AdminState {}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ───
class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _repository;

  AdminBloc(this._repository) : super(AdminInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<CreateUserRequested>(_onCreateUser);
    on<UpdateUserRequested>(_onUpdateUser);
    on<ToggleUserActiveRequested>(_onToggleUserActive);
    on<LoadMasterTable>(_onLoadMasterTable);
    on<InsertMasterItemRequested>(_onInsertMasterItem);
    on<UpdateMasterItemRequested>(_onUpdateMasterItem);
    on<DeleteMasterItemRequested>(_onDeleteMasterItem);
    on<LoadMasterLookup>(_onLoadMasterLookup);
    on<SaveMasterWeightEntry>(_onSaveWeightEntry);
    on<DeleteMasterWeightEntry>(_onDeleteWeightEntry);
    on<SaveMasterTargetEntry>(_onSaveTargetEntry);
    on<DeleteMasterTargetEntry>(_onDeleteTargetEntry);
    on<LoadSalaryWeightages>(_onLoadSalaryWeightages);
    on<SaveSalaryWeightage>(_onSaveSalaryWeightage);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final users = await _repository.getAllUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onCreateUser(
    CreateUserRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.createUser(
        name: event.name,
        phone: event.phone,
        password: event.password,
        roles: event.roles,
        assignedMachines: event.assignedMachines,
        fixedSalary: event.fixedSalary,
      );
      emit(UserSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.updateUser(event.user);
      emit(UserSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onToggleUserActive(
    ToggleUserActiveRequested event,
    Emitter<AdminState> emit,
  ) async {
    try {
      await _repository.toggleUserActive(event.uid, event.isActive);
      add(LoadUsers());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  // ── Master dropdown tables ──

  Future<void> _onLoadMasterTable(
    LoadMasterTable event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      final items = await _repository.getMasterTable(event.tableType);
      emit(MasterTableLoaded(event.tableType, items));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onInsertMasterItem(
    InsertMasterItemRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.insertMasterItem(event.tableType, event.item);
      emit(MasterItemSaved(event.tableType));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onUpdateMasterItem(
    UpdateMasterItemRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.updateMasterItem(event.tableType, event.item);
      emit(MasterItemSaved(event.tableType));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onDeleteMasterItem(
    DeleteMasterItemRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.deleteMasterItem(event.tableType, event.id);
      emit(MasterItemSaved(event.tableType));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  // ── Master lookup tables ──

  Future<void> _onLoadMasterLookup(
    LoadMasterLookup event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      switch (event.lookupType) {
        case MasterLookupType.frameWeights:
        case MasterLookupType.sheetWeights:
          final entries = await _repository.getWeightTable(event.lookupType);
          emit(MasterWeightsLoaded(event.lookupType, entries));
        case MasterLookupType.frameTargets:
        case MasterLookupType.sheetTargets:
        case MasterLookupType.scrapTargets:
          final entries = await _repository.getTargetTable(event.lookupType);
          emit(MasterTargetsLoaded(event.lookupType, entries));
        case MasterLookupType.salaryWeightages:
          final entries = await _repository.getSalaryWeightages();
          emit(SalaryWeightagesLoaded(entries));
      }
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onSaveWeightEntry(
    SaveMasterWeightEntry event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      if (event.isNew) {
        await _repository.insertWeightEntry(event.lookupType, event.entry);
      } else {
        await _repository.updateWeightEntry(event.lookupType, event.entry);
      }
      emit(MasterLookupSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onDeleteWeightEntry(
    DeleteMasterWeightEntry event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.deleteWeightEntry(event.lookupType, event.id);
      emit(MasterLookupSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onSaveTargetEntry(
    SaveMasterTargetEntry event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      if (event.isNew) {
        await _repository.insertTargetEntry(event.lookupType, event.entry);
      } else {
        await _repository.updateTargetEntry(event.lookupType, event.entry);
      }
      emit(MasterLookupSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onDeleteTargetEntry(
    DeleteMasterTargetEntry event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      await _repository.deleteTargetEntry(event.lookupType, event.id);
      emit(MasterLookupSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onLoadSalaryWeightages(
    LoadSalaryWeightages event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      final entries = await _repository.getSalaryWeightages(
        category: event.category,
      );
      emit(SalaryWeightagesLoaded(entries));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onSaveSalaryWeightage(
    SaveSalaryWeightage event,
    Emitter<AdminState> emit,
  ) async {
    emit(AdminLoading());
    try {
      if (event.isNew) {
        await _repository.insertSalaryWeightage(event.entry);
      } else {
        await _repository.updateSalaryWeightage(event.entry);
      }
      emit(MasterLookupSaved());
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
