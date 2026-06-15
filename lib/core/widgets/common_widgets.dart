import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class AutoCalculatedField extends StatelessWidget {
  final String label;
  final String value;

  const AutoCalculatedField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.autoFieldBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderGrey),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            size: 16,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailing;
  final VoidCallback? onTap;
  final Color? statusColor;

  const ReportCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: trailing != null
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (statusColor ?? AppTheme.primaryNavy).withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  trailing!,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: statusColor ?? AppTheme.primaryNavy,
                  ),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppTheme.primaryNavy),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(48),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 96),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: AppTheme.textSecondary),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onAction,
                    child: Text(actionLabel!),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class PaginatedListView<T> extends StatefulWidget {
  final List<T> items;
  final Future<void> Function()? onRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String emptyMessage;
  final IconData emptyIcon;
  final int pageSize;
  final EdgeInsetsGeometry padding;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.emptyMessage,
    this.onRefresh,
    this.emptyIcon = Icons.inbox_outlined,
    this.pageSize = 30,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late int _visibleCount;

  @override
  void initState() {
    super.initState();
    _visibleCount = math.min(widget.pageSize, widget.items.length);
  }

  @override
  void didUpdateWidget(covariant PaginatedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _visibleCount = math.min(widget.pageSize, widget.items.length);
      return;
    }
    if (_visibleCount > widget.items.length) {
      _visibleCount = widget.items.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          EmptyStateWidget(
            message: widget.emptyMessage,
            icon: widget.emptyIcon,
          ),
        ],
      );
    }

    final hasMore = _visibleCount < widget.items.length;
    final listView = ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: widget.padding,
      itemCount: _visibleCount + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _visibleCount) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _visibleCount = math.min(
                      _visibleCount + widget.pageSize,
                      widget.items.length,
                    );
                  });
                },
                icon: const Icon(Icons.expand_more),
                label: Text(
                  'Load More (${widget.items.length - _visibleCount})',
                ),
              ),
            ),
          );
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );

    if (widget.onRefresh == null) {
      return listView;
    }

    return RefreshIndicator(onRefresh: widget.onRefresh!, child: listView);
  }
}

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.warningYellow,
      child: const Row(
        children: [
          Icon(Icons.wifi_off, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'You are offline — data will sync when connected',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmSubmitDialog extends StatelessWidget {
  final String title;
  final String message;

  const ConfirmSubmitDialog({
    super.key,
    this.title = 'Confirm Submission',
    this.message = 'Once submitted, this report cannot be edited. Submit?',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class RatingBoxes extends StatelessWidget {
  final String label;
  final String? helperText;
  final TextEditingController controller;
  final VoidCallback onChanged;

  const RatingBoxes({
    super.key,
    required this.label,
    this.helperText,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = int.tryParse(controller.text) ?? 0;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderGrey),
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.surfaceCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            helperText ?? '1 = Poor, 10 = Excellent',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(10, (i) {
              final value = i + 1;
              final isSelected = value == selected;
              Color bgColor;
              if (!isSelected) {
                bgColor = Colors.grey[200]!;
              } else if (value <= 3) {
                bgColor = AppTheme.errorRed;
              } else if (value <= 6) {
                bgColor = AppTheme.warningYellow;
              } else {
                bgColor = AppTheme.successGreen;
              }
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.text = value.toString();
                    onChanged();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: i < 9 ? 4 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(6),
                      border: isSelected
                          ? Border.all(color: Colors.black87, width: 2)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          if (selected == 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Please select a rating',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
