import 'package:flutter/material.dart';

/// A generic read-only detail view for submitted reports.
///
/// [title] is shown in the AppBar.
/// [fields] is an ordered list of label-value pairs displayed as rows.
/// [sections] is an optional list of named sections each containing
/// their own list of label-value rows (e.g. line items, ratings).
class ReportDetailPage extends StatelessWidget {
  final String title;
  final List<ReportField> fields;
  final List<ReportSection>? sections;

  const ReportDetailPage({
    super.key,
    required this.title,
    required this.fields,
    this.sections,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < fields.length; i++) ...[
                    if (i > 0) const Divider(height: 24),
                    _FieldRow(field: fields[i]),
                  ],
                ],
              ),
            ),
          ),
          if (sections != null)
            for (final section in sections!) ...[
              const SizedBox(height: 16),
              Text(
                section.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              for (var j = 0; j < section.items.length; j++)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.items[j].heading ??
                              '${section.itemLabel ?? 'Item'} ${j + 1}',
                          style: theme.textTheme.titleSmall,
                        ),
                        const Divider(height: 16),
                        for (
                          var k = 0;
                          k < section.items[j].fields.length;
                          k++
                        ) ...[
                          if (k > 0) const SizedBox(height: 6),
                          _FieldRow(field: section.items[j].fields[k]),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  final ReportField field;

  const _FieldRow({required this.field});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            field.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            field.value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// A single label-value pair.
class ReportField {
  final String label;
  final String value;
  const ReportField(this.label, this.value);
}

/// A section containing a list of items, each with their own fields.
class ReportSection {
  final String title;
  final String? itemLabel;
  final List<ReportSectionItem> items;
  const ReportSection({
    required this.title,
    this.itemLabel,
    required this.items,
  });
}

/// A single item within a section (e.g. a line item or a rating entry).
class ReportSectionItem {
  final String? heading;
  final List<ReportField> fields;
  const ReportSectionItem({this.heading, required this.fields});
}
