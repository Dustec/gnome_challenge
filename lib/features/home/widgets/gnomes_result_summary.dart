import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';

class GnomesResultSummary extends StatelessWidget {
  const GnomesResultSummary({
    required this.total,
    required this.filtered,
    required this.query,
    required this.onClearQuery,
    super.key,
  });

  final AsyncValue<List<Gnome>> total;
  final AsyncValue<List<Gnome>> filtered;
  final String query;
  final VoidCallback onClearQuery;

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim();
    final isFiltered = normalizedQuery.isNotEmpty;
    final totalCount = total.asData?.value.length;
    final filteredCount = filtered.asData?.value.length;

    final summaryText = _summaryText(
      totalCount: totalCount,
      filteredCount: filteredCount,
      isFiltered: isFiltered,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              summaryText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (isFiltered)
            TextButton.icon(
              onPressed: onClearQuery,
              icon: const Icon(Icons.close, size: 16),
              label: const Text('Clear'),
            ),
        ],
      ),
    );
  }

  String _summaryText({
    required int? totalCount,
    required int? filteredCount,
    required bool isFiltered,
  }) {
    if (filtered.isLoading) {
      return 'Loading heroes...';
    }

    if (filtered.hasError) {
      return 'Unable to load heroes';
    }

    if (!isFiltered) {
      if (totalCount == null) {
        return 'Heroes';
      }

      return '$totalCount heroes';
    }

    final shown = filteredCount ?? 0;
    final totalHeroes = totalCount ?? shown;
    return '$shown of $totalHeroes heroes';
  }
}
