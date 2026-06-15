import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/frame_entities.dart';
import '../bloc/frame_reports_bloc.dart';

class FrameToolsCountFormPage extends StatefulWidget {
  const FrameToolsCountFormPage({super.key});

  @override
  State<FrameToolsCountFormPage> createState() =>
      _FrameToolsCountFormPageState();
}

class _FrameToolsCountFormPageState extends State<FrameToolsCountFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _machineNumber;
  final _toolsGivenCtrl = TextEditingController();
  final _toolsAvailableCtrl = TextEditingController();

  double get _percentage {
    final given = int.tryParse(_toolsGivenCtrl.text) ?? 0;
    final available = int.tryParse(_toolsAvailableCtrl.text) ?? 0;
    if (given == 0) return 0;
    return (available / given) * 100;
  }

  @override
  void dispose() {
    _toolsGivenCtrl.dispose();
    _toolsAvailableCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_machineNumber == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmSubmitDialog(),
    );
    if (confirmed != true || !mounted) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;

    final given = int.parse(_toolsGivenCtrl.text);
    final available = int.parse(_toolsAvailableCtrl.text);

    context.read<FrameReportsBloc>().add(
      SubmitToolsCountReport(
        ToolsCountReport(
          date: _date,
          machineNumber: _machineNumber!,
          totalToolsGiven: given,
          totalToolsAvailable: available,
          percentageAvailable: _percentage,
          createdBy: authState.user.uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FrameReportsBloc, FrameReportsState>(
      listener: (context, state) {
        if (state is FrameReportsSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.successGreen,
            ),
          );
          Navigator.pop(context);
          context.read<FrameReportsBloc>().add(LoadToolsCountReports());
        }
        if (state is FrameReportsError) {
          debugPrint('FrameReportsError: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Tools Count Report')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Date'),
                    subtitle: Text(DateFormat('dd MMM yyyy').format(_date)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _machineNumber,
                  decoration: const InputDecoration(
                    labelText: 'Machine Number',
                  ),
                  items: ddp.frameMachines
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setState(() => _machineNumber = v),
                  validator: (v) => v == null ? 'Select machine' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _toolsGivenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Total Number of Tools Given',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  validator: (v) => (int.tryParse(v ?? '') ?? 0) <= 0
                      ? 'Enter a number'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _toolsAvailableCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Total Number of Tools Available',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  validator: (v) => (int.tryParse(v ?? '') ?? 0) < 0
                      ? 'Enter a number'
                      : null,
                ),
                const SizedBox(height: 16),
                AutoCalculatedField(
                  label: 'Percentage of Tools Available',
                  value: '${_percentage.toStringAsFixed(1)}%',
                ),
                const SizedBox(height: 32),
                BlocBuilder<FrameReportsBloc, FrameReportsState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is FrameReportsSubmitting
                          ? null
                          : _submit,
                      child: state is FrameReportsSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Submit Report'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
