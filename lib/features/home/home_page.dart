import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/features/gnomes/presentation/providers/gnomes_providers.dart';
import 'package:gnome_challenge/features/home/widgets/gnomes_content.dart';
import 'package:gnome_challenge/features/home/widgets/gnomes_result_summary.dart';
import 'package:gnome_challenge/features/home/widgets/gnomes_search_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allGnomes = ref.watch(gnomesListProvider);
    final filteredGnomes = ref.watch(filteredGnomesProvider(_query));

    return Scaffold(
      appBar: AppBar(title: const Text('Brastlewark Heroes')),
      body: SafeArea(
        child: Column(
          children: [
            GnomesSearchBar(
              controller: _searchController,
              onChanged: _onQueryChanged,
            ),
            GnomesResultSummary(
              total: allGnomes,
              filtered: filteredGnomes,
              query: _query,
              onClearQuery: _clearQuery,
            ),
            Expanded(
              child: GnomesContent(
                gnomes: filteredGnomes,
                onRefresh: () => ref.refresh(gnomesListProvider.future),
                onRetry: () => ref.invalidate(gnomesListProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQueryChanged(String value) {
    setState(() {
      _query = value;
    });
  }

  void _clearQuery() {
    _searchController.clear();
    setState(() {
      _query = '';
    });
  }
}
