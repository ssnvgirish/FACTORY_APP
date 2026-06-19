import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/services/dropdown_config_provider.dart';
import '../../../../core/theme/app_theme.dart';

enum ReportGenerationType { machineAndTimeRange, operatorWise }

class ReportTarget {
  const ReportTarget({required this.id, required this.name});

  final String id;
  final String name;

  String get displayLabel => '$id - $name';
}

class ReportRequest {
  const ReportRequest({
    required this.type,
    required this.target,
    this.start,
    this.end,
  });

  final ReportGenerationType type;
  final ReportTarget target;
  final DateTime? start;
  final DateTime? end;
}

class ReportsTabController extends ChangeNotifier {
  ReportsTabController({
    required this.machineOptions,
    required this.operatorOptions,
  });

  final List<ReportTarget> machineOptions;
  final List<ReportTarget> operatorOptions;

  ReportGenerationType selectedType = ReportGenerationType.machineAndTimeRange;

  ReportTarget? selectedMachine;
  DateTime? machineStart;
  DateTime? machineEnd;

  ReportTarget? selectedOperator;
  DateTime? operatorStart;
  DateTime? operatorEnd;

  bool isSubmitting = false;
  bool showValidationErrors = false;

  String? get machineSelectionError {
    if (!showValidationErrors ||
        selectedType != ReportGenerationType.machineAndTimeRange) {
      return null;
    }
    return selectedMachine == null ? 'Please select a machine.' : null;
  }

  String? get machineRangeError {
    if (!showValidationErrors ||
        selectedType != ReportGenerationType.machineAndTimeRange) {
      return null;
    }
    if (machineStart == null || machineEnd == null) {
      return 'Please select both start and end date/time.';
    }
    if (machineEnd!.isBefore(machineStart!)) {
      return 'End date/time must be after start date/time.';
    }
    return null;
  }

  String? get operatorSelectionError {
    if (!showValidationErrors ||
        selectedType != ReportGenerationType.operatorWise) {
      return null;
    }
    return selectedOperator == null ? 'Please select an operator.' : null;
  }

  String? get operatorRangeError {
    if (!showValidationErrors ||
        selectedType != ReportGenerationType.operatorWise) {
      return null;
    }
    if (operatorStart != null &&
        operatorEnd != null &&
        operatorEnd!.isBefore(operatorStart!)) {
      return 'End date/time must be after start date/time.';
    }
    return null;
  }

  bool get canSubmit {
    if (isSubmitting) return false;

    if (selectedType == ReportGenerationType.machineAndTimeRange) {
      return selectedMachine != null &&
          machineStart != null &&
          machineEnd != null &&
          !machineEnd!.isBefore(machineStart!);
    }

    if (selectedOperator == null) return false;

    if (operatorStart != null && operatorEnd != null) {
      return !operatorEnd!.isBefore(operatorStart!);
    }

    return true;
  }

  void setType(ReportGenerationType type) {
    selectedType = type;
    showValidationErrors = false;
    notifyListeners();
  }

  void setMachine(ReportTarget? machine) {
    selectedMachine = machine;
    notifyListeners();
  }

  void setMachineStart(DateTime? value) {
    machineStart = value;
    notifyListeners();
  }

  void setMachineEnd(DateTime? value) {
    machineEnd = value;
    notifyListeners();
  }

  void setOperator(ReportTarget? operator) {
    selectedOperator = operator;
    notifyListeners();
  }

  void setOperatorStart(DateTime? value) {
    operatorStart = value;
    notifyListeners();
  }

  void setOperatorEnd(DateTime? value) {
    operatorEnd = value;
    notifyListeners();
  }

  void clearOperatorDateFilters() {
    operatorStart = null;
    operatorEnd = null;
    notifyListeners();
  }

  ReportRequest? buildRequest() {
    if (selectedType == ReportGenerationType.machineAndTimeRange) {
      if (!canSubmit || selectedMachine == null) return null;
      return ReportRequest(
        type: selectedType,
        target: selectedMachine!,
        start: machineStart,
        end: machineEnd,
      );
    }

    if (!canSubmit || selectedOperator == null) return null;
    return ReportRequest(
      type: selectedType,
      target: selectedOperator!,
      start: operatorStart,
      end: operatorEnd,
    );
  }

  Future<ReportRequest?> submit() async {
    showValidationErrors = true;
    notifyListeners();

    final request = buildRequest();
    if (request == null) return null;

    isSubmitting = true;
    notifyListeners();

    return request;
  }

  void finishSubmission() {
    isSubmitting = false;
    notifyListeners();
  }
}

class ReportsTabPage extends StatefulWidget {
  const ReportsTabPage({
    super.key,
    this.machineOptions,
    this.operatorOptions,
    this.onGenerateReport,
  });

  final List<ReportTarget>? machineOptions;
  final List<ReportTarget>? operatorOptions;

  // Inject your real repository/API callback here.
  final Future<void> Function(ReportRequest request)? onGenerateReport;

  @override
  State<ReportsTabPage> createState() => _ReportsTabPageState();
}

class _ReportsTabPageState extends State<ReportsTabPage> {
  late ReportsTabController _controller;
  final DateFormat _dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');
  late List<ReportTarget> _machines;
  late List<ReportTarget> _operators;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _machines = [];
    _operators = [];
    _controller = ReportsTabController(
      machineOptions: _machines,
      operatorOptions: _operators,
    );
    _loadMasterData();
  }

  Future<void> _loadMasterData() async {
    try {
      final provider = sl<DropdownConfigProvider>();
      
      // Get machines from provider
      final machineNames = widget.machineOptions?.map((m) => m.name).toList() ?? provider.allMachines;
      _machines = machineNames
          .asMap()
          .entries
          .map((e) => ReportTarget(id: 'MC-${e.key + 1}', name: e.value))
          .toList();

      // For operators, use mock data (update this to call your operator API if available)
      _operators = widget.operatorOptions ??
          const [
            ReportTarget(id: 'OP-101', name: 'Arjun Patel'),
            ReportTarget(id: 'OP-102', name: 'Meera Rao'),
            ReportTarget(id: 'OP-103', name: 'Ravi Kumar'),
            ReportTarget(id: 'OP-104', name: 'Nisha Sharma'),
          ];

      if (mounted) {
        setState(() {
          _controller = ReportsTabController(
            machineOptions: _machines,
            operatorOptions: _operators,
          );
          _isLoaded = true;
        });
      }
    } catch (error) {
      debugPrint('Error loading master data: $error');
      // Fallback to defaults
      if (mounted) {
        setState(() {
          _machines = widget.machineOptions ??
              const [
                ReportTarget(id: 'MC-001', name: 'Frame Cutter'),
                ReportTarget(id: 'MC-002', name: 'Edge Sealer'),
                ReportTarget(id: 'MC-003', name: 'Auto Laminator'),
              ];
          _operators = widget.operatorOptions ??
              const [
                ReportTarget(id: 'OP-101', name: 'Arjun Patel'),
                ReportTarget(id: 'OP-102', name: 'Meera Rao'),
              ];
          _controller = ReportsTabController(
            machineOptions: _machines,
            operatorOptions: _operators,
          );
          _isLoaded = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while machines are being fetched
    if (!_isLoaded) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reports')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: SafeArea(
        top: false,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 840),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Generate machine or operator based reports.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildReportTypeSelector(context),
                      const SizedBox(height: 16),
                      _buildTypeDescription(context),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildActiveFormSafe(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActiveFormSafe(BuildContext context) {
    try {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child:
            _controller.selectedType == ReportGenerationType.machineAndTimeRange
            ? _buildMachineAndTimeRangeForm(context)
            : _buildOperatorWiseForm(context),
      );
    } catch (error) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Failed to render reports form: $error',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
  }

  Widget _buildReportTypeSelector(BuildContext context) {
    return SegmentedButton<ReportGenerationType>(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment<ReportGenerationType>(
          value: ReportGenerationType.machineAndTimeRange,
          icon: Icon(Icons.precision_manufacturing),
          label: Text('Machine & Time Range'),
        ),
        ButtonSegment<ReportGenerationType>(
          value: ReportGenerationType.operatorWise,
          icon: Icon(Icons.engineering),
          label: Text('Operator Wise'),
        ),
      ],
      selected: {_controller.selectedType},
      onSelectionChanged: (value) {
        _controller.setType(value.first);
      },
      style: SegmentedButton.styleFrom(
        minimumSize: const Size(0, 48),
        textStyle: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget _buildTypeDescription(BuildContext context) {
    final selectedType = _controller.selectedType;
    final isMachineType =
        selectedType == ReportGenerationType.machineAndTimeRange;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryNavy.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          Icon(
            isMachineType ? Icons.schedule : Icons.person_search,
            color: AppTheme.primaryNavy,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isMachineType
                  ? 'Generate reports by selecting a machine and exact start/end date-time.'
                  : 'Generate reports by operator with optional date filters.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMachineAndTimeRangeForm(BuildContext context) {
    return Column(
      key: const ValueKey('machine_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SelectionDropdown<ReportTarget>(
          label: 'Machine ID / Machine Name',
          hintText: 'Search machine...',
          value: _controller.selectedMachine,
          entries: _controller.machineOptions,
          itemLabel: (target) => target.displayLabel,
          onSelected: _controller.setMachine,
          errorText: _controller.machineSelectionError,
          leadingIcon: Icons.precision_manufacturing,
        ),
        const SizedBox(height: 16),
        _DateTimeRangeSection(
          title: 'Date-Time Range',
          startLabel: 'Start Date/Time',
          endLabel: 'End Date/Time',
          startValue: _controller.machineStart,
          endValue: _controller.machineEnd,
          dateTimeFormat: _dateTimeFormat,
          onPickStart: () async {
            final picked = await _pickDateTime(
              context,
              _controller.machineStart,
            );
            _controller.setMachineStart(picked);
          },
          onPickEnd: () async {
            final picked = await _pickDateTime(context, _controller.machineEnd);
            _controller.setMachineEnd(picked);
          },
          errorText: _controller.machineRangeError,
        ),
        const SizedBox(height: 24),
        _GenerateButton(
          isSubmitting: _controller.isSubmitting,
          enabled: _controller.canSubmit,
          onPressed: _onGeneratePressed,
        ),
      ],
    );
  }

  Widget _buildOperatorWiseForm(BuildContext context) {
    return Column(
      key: const ValueKey('operator_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SelectionDropdown<ReportTarget>(
          label: 'Operator ID / Operator Name',
          hintText: 'Search operator...',
          value: _controller.selectedOperator,
          entries: _controller.operatorOptions,
          itemLabel: (target) => target.displayLabel,
          onSelected: _controller.setOperator,
          errorText: _controller.operatorSelectionError,
          leadingIcon: Icons.engineering,
        ),
        const SizedBox(height: 16),
        _DateTimeRangeSection(
          title: 'Date-Time Filter (Optional)',
          startLabel: 'Start Date/Time',
          endLabel: 'End Date/Time',
          startValue: _controller.operatorStart,
          endValue: _controller.operatorEnd,
          dateTimeFormat: _dateTimeFormat,
          onPickStart: () async {
            final picked = await _pickDateTime(
              context,
              _controller.operatorStart,
            );
            _controller.setOperatorStart(picked);
          },
          onPickEnd: () async {
            final picked = await _pickDateTime(
              context,
              _controller.operatorEnd,
            );
            _controller.setOperatorEnd(picked);
          },
          onClear: _controller.clearOperatorDateFilters,
          errorText: _controller.operatorRangeError,
        ),
        const SizedBox(height: 24),
        _GenerateButton(
          isSubmitting: _controller.isSubmitting,
          enabled: _controller.canSubmit,
          onPressed: _onGeneratePressed,
        ),
      ],
    );
  }

  Future<void> _onGeneratePressed() async {
    final request = await _controller.submit();
    if (request == null) return;

    try {
      if (widget.onGenerateReport != null) {
        await widget.onGenerateReport!(request);
      }

      if (!mounted) return;

      // Navigate to results page with request data
      final typeParam = request.type == ReportGenerationType.machineAndTimeRange
          ? 'machine'
          : 'operator';
      final startParam = request.start?.millisecondsSinceEpoch.toString() ?? '0';
      final endParam = request.end?.millisecondsSinceEpoch.toString() ?? '0';

      final uri = '/report/results/$typeParam/${request.target.id}/${request.target.name}/$startParam/$endParam';

      context.push(uri);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate report: $error')),
      );
    } finally {
      _controller.finishSubmission();
    }
  }

  Future<DateTime?> _pickDateTime(
    BuildContext context,
    DateTime? initial,
  ) async {
    final now = DateTime.now();
    final initialDate = initial ?? now;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 3),
    );

    if (pickedDate == null || !context.mounted) return null;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}

class _SelectionDropdown<T> extends StatelessWidget {
  const _SelectionDropdown({
    required this.label,
    required this.hintText,
    required this.value,
    required this.entries,
    required this.itemLabel,
    required this.onSelected,
    this.errorText,
    this.leadingIcon,
  });

  final String label;
  final String hintText;
  final T? value;
  final List<T> entries;
  final String Function(T item) itemLabel;
  final ValueChanged<T?> onSelected;
  final String? errorText;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<T>(
          width: constraints.maxWidth,
          initialSelection: value,
          requestFocusOnTap: true,
          enableFilter: true,
          leadingIcon: leadingIcon == null ? null : Icon(leadingIcon),
          label: Text(label),
          hintText: hintText,
          errorText: errorText,
          onSelected: onSelected,
          dropdownMenuEntries: entries
              .map(
                (item) =>
                    DropdownMenuEntry<T>(value: item, label: itemLabel(item)),
              )
              .toList(),
        );
      },
    );
  }
}

class _DateTimeRangeSection extends StatelessWidget {
  const _DateTimeRangeSection({
    required this.title,
    required this.startLabel,
    required this.endLabel,
    required this.startValue,
    required this.endValue,
    required this.dateTimeFormat,
    required this.onPickStart,
    required this.onPickEnd,
    this.onClear,
    this.errorText,
  });

  final String title;
  final String startLabel;
  final String endLabel;
  final DateTime? startValue;
  final DateTime? endValue;
  final DateFormat dateTimeFormat;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final VoidCallback? onClear;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final hasSelection = startValue != null || endValue != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            if (onClear != null && hasSelection)
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear),
                label: const Text('Clear'),
              ),
          ],
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 680;

            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _DateTimeField(
                      label: startLabel,
                      value: startValue,
                      dateTimeFormat: dateTimeFormat,
                      onTap: onPickStart,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateTimeField(
                      label: endLabel,
                      value: endValue,
                      dateTimeFormat: dateTimeFormat,
                      onTap: onPickEnd,
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DateTimeField(
                  label: startLabel,
                  value: startValue,
                  dateTimeFormat: dateTimeFormat,
                  onTap: onPickStart,
                ),
                const SizedBox(height: 12),
                _DateTimeField(
                  label: endLabel,
                  value: endValue,
                  dateTimeFormat: dateTimeFormat,
                  onTap: onPickEnd,
                ),
              ],
            );
          },
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.label,
    required this.value,
    required this.dateTimeFormat,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final DateFormat dateTimeFormat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final displayText = value == null
        ? 'Select date and time'
        : dateTimeFormat.format(value!);

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        alignment: Alignment.centerLeft,
        foregroundColor: AppTheme.textPrimary,
      ),
      onPressed: onTap,
      icon: const Icon(Icons.calendar_today_outlined),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(displayText, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({
    required this.isSubmitting,
    required this.enabled,
    required this.onPressed,
  });

  final bool isSubmitting;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: enabled && !isSubmitting ? onPressed : null,
      icon: isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.analytics_outlined),
      label: Text(isSubmitting ? 'Generating...' : 'Generate Report'),
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
    );
  }
}
