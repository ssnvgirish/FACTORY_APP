import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/entities/admin_entities.dart';
import '../bloc/admin_bloc.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const _UserFormPage()),
        ),
        child: const Icon(Icons.person_add),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) return const LoadingWidget();
          if (state is AdminError) {
            debugPrint('AdminError: ${state.message}');
            return EmptyStateWidget(
              message: 'Something went wrong',
              icon: Icons.error_outline,
              actionLabel: 'Retry',
              onAction: () => context.read<AdminBloc>().add(LoadUsers()),
            );
          }
          if (state is UsersLoaded) {
            if (state.users.isEmpty) {
              return const EmptyStateWidget(message: 'No users found');
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.users.length,
              itemBuilder: (context, i) => _UserCard(user: state.users[i]),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final ManagedUser user;
  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: user.isActive ? AppTheme.successGreen : Colors.grey,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.phone.isNotEmpty ? user.phone : user.email,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: user.roles
                  .map(
                    (r) => Chip(
                      label: Text(r, style: const TextStyle(fontSize: 11)),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (v) {
            if (v == 'toggle') {
              context.read<AdminBloc>().add(
                ToggleUserActiveRequested(user.uid, !user.isActive),
              );
            } else if (v == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => _UserFormPage(user: user)),
              );
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(
              value: 'toggle',
              child: Text(user.isActive ? 'Deactivate' : 'Activate'),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

class _UserFormPage extends StatefulWidget {
  final ManagedUser? user;
  const _UserFormPage({this.user});

  @override
  State<_UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<_UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _salaryCtrl;
  late List<String> _selectedRoles;
  late List<String> _selectedMachines;

  bool get _isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user?.name ?? '');
    _phoneCtrl = TextEditingController(text: widget.user?.phone ?? '');
    _passwordCtrl = TextEditingController();
    _salaryCtrl = TextEditingController(
      text: widget.user?.fixedSalary.toStringAsFixed(0) ?? '',
    );
    _selectedRoles = List<String>.from(widget.user?.roles ?? []);
    _selectedMachines = List<String>.from(widget.user?.assignedMachines ?? []);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _salaryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit User' : 'Create User')),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is UserSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User saved'),
                backgroundColor: AppTheme.successGreen,
              ),
            );
            context.read<AdminBloc>().add(LoadUsers());
            Navigator.pop(context);
          }
          if (state is AdminError) {
            debugPrint('AdminError: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixText: '+91 ',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  enabled: !_isEditing,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (v.length != 10) return 'Enter a valid 10-digit number';
                    return null;
                  },
                ),
                if (!_isEditing) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordCtrl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.length < 4) {
                        return 'Min 4 characters';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: _salaryCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Fixed Salary (₹)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0
                      ? 'Enter valid salary'
                      : null,
                ),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Roles'),
                Wrap(
                  spacing: 8,
                  children: ddp.roles
                      .map(
                        (role) => FilterChip(
                          label: Text(role),
                          selected: _selectedRoles.contains(role),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedRoles.add(role);
                              } else {
                                _selectedRoles.remove(role);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Assigned Machines'),
                Wrap(
                  spacing: 8,
                  children: ddp.allMachines
                      .map(
                        (m) => FilterChip(
                          label: Text(m),
                          selected: _selectedMachines.contains(m),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedMachines.add(m);
                              } else {
                                _selectedMachines.remove(m);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isEditing ? 'Update User' : 'Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRoles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Select at least one role')));
      return;
    }

    if (_isEditing) {
      context.read<AdminBloc>().add(
        UpdateUserRequested(
          ManagedUser(
            uid: widget.user!.uid,
            name: _nameCtrl.text.trim(),
            phone: widget.user!.phone,
            email: widget.user!.email,
            roles: _selectedRoles,
            assignedMachines: _selectedMachines,
            fixedSalary: double.parse(_salaryCtrl.text),
            isActive: widget.user!.isActive,
          ),
        ),
      );
    } else {
      context.read<AdminBloc>().add(
        CreateUserRequested(
          name: _nameCtrl.text.trim(),
          phone: '+91${_phoneCtrl.text.trim()}',
          password: _passwordCtrl.text,
          roles: _selectedRoles,
          assignedMachines: _selectedMachines,
          fixedSalary: double.parse(_salaryCtrl.text),
        ),
      );
    }
  }
}
