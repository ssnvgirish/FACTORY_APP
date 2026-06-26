import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../bloc/scrap_regrind_bloc.dart';

class ScrapQualityReportFormPage extends StatefulWidget {
  const ScrapQualityReportFormPage({super.key});

  @override
  State<ScrapQualityReportFormPage> createState() =>
      _ScrapQualityReportFormPageState();
}

class _ScrapQualityReportFormPageState
    extends State<ScrapQualityReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMachine;
  String? _selectedShift;
  String? _selectedProduct;
  int _qualityRating = 5;
  final _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScrapRegrindBloc, ScrapRegrindState>(
      listener: (context, state) {
        if (state is ScrapRegrindSubmitted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pop(context);
        } else if (state is ScrapRegrindError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New Scrap Quality Report')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                title: const Text('Date'),
                subtitle: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedMachine,
                decoration: const InputDecoration(labelText: 'Machine Number'),
                items: AppConstants.scrapQualityMachines
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMachine = v),
                validator: (v) => v == null ? 'Select a machine' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedShift,
                decoration: const InputDecoration(labelText: 'Shift'),
                items: AppConstants.shifts
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedShift = v),
                validator: (v) => v == null ? 'Select a shift' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedProduct,
                decoration: const InputDecoration(labelText: 'Product'),
                items: AppConstants.scrapProducts
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedProduct = v),
                validator: (v) => v == null ? 'Select a product' : null,
              ),
              const SizedBox(height: 16),
              Text('Quality Rating: $_qualityRating / 10'),
              Slider(
                value: _qualityRating.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: _qualityRating.toString(),
                onChanged: (v) => setState(() => _qualityRating = v.round()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentsController,
                decoration: const InputDecoration(
                  labelText: 'Comments (optional)',
                  hintText: 'Enter any observations or notes',
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              BlocBuilder<ScrapRegrindBloc, ScrapRegrindState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is ScrapRegrindSubmitting
                        ? null
                        : _submitReport,
                    child: state is ScrapRegrindSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Submit Report'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReport() {
    if (!_formKey.currentState!.validate()) return;

    final comments = _commentsController.text.trim();
    final report = ScrapQualityReport(
      date: _selectedDate,
      machineNumber: _selectedMachine!,
      shift: _selectedShift!,
      product: _selectedProduct!,
      qualityRating: _qualityRating,
      comments: comments.isNotEmpty ? comments : null,
      createdBy: '', // Set from auth
    );

    context.read<ScrapRegrindBloc>().add(SubmitScrapQualityReport(report));
  }
}
