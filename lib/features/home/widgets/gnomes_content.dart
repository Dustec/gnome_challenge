import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';
import 'package:gnome_challenge/features/home/widgets/gnomes_list_view.dart';
import 'package:gnome_challenge/features/home/widgets/gnomes_state_views.dart';

class GnomesContent extends StatelessWidget {
  const GnomesContent({
    required this.gnomes,
    required this.onRefresh,
    required this.onRetry,
    super.key,
  });

  final AsyncValue<List<Gnome>> gnomes;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return gnomes.when(
      data: (items) {
        if (items.isEmpty) {
          return const GnomesEmptyView();
        }

        return GnomesListView(items: items, onRefresh: onRefresh);
      },
      loading: GnomesLoadingView.new,
      error: (error, _) => GnomesErrorView(error: error, onRetry: onRetry),
    );
  }
}
