import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/features/gnomes/di/gnomes_providers.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';

final gnomesListProvider = FutureProvider<List<Gnome>>((ref) {
  final repository = ref.watch(gnomesRepositoryProvider);
  return repository.fetchGnomes();
});

final filteredGnomesProvider =
    Provider.family<AsyncValue<List<Gnome>>, String>((ref, query) {
  final gnomes = ref.watch(gnomesListProvider);
  final normalizedQuery = query.trim().toLowerCase();

  return gnomes.whenData((items) {
    if (normalizedQuery.isEmpty) {
      return items;
    }

    return items.where((gnome) {
      final professionMatch = gnome.professions.any(
        (profession) => profession.toLowerCase().contains(normalizedQuery),
      );

      return gnome.name.toLowerCase().contains(normalizedQuery) ||
          professionMatch;
    }).toList(growable: false);
  });
});
