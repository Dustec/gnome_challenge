import 'package:flutter/material.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';
import 'package:gnome_challenge/features/home/widgets/gnome_list_tile.dart';

class GnomesListView extends StatelessWidget {
  const GnomesListView({
    required this.items,
    required this.onRefresh,
    super.key,
  });

  final List<Gnome> items;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemBuilder: (context, index) {
          final gnome = items[index];
          return GnomeListTile(gnome: gnome);
        },
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemCount: items.length,
      ),
    );
  }
}
