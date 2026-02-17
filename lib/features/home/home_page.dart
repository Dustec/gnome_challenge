import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';
import 'package:gnome_challenge/features/gnomes/presentation/providers/gnomes_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final gnomes = ref.watch(filteredGnomesProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brastlewark Heroes'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search by name or profession',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: gnomes.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(
                      child: Text('No gnomes found for this search.'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      return ref.refresh(gnomesListProvider.future);
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemBuilder: (context, index) {
                        final gnome = items[index];
                        return _GnomeTile(gnome: gnome);
                      },
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemCount: items.length,
                    ),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, _) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Could not load gnomes. Try again in a moment.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: () {
                              ref.invalidate(gnomesListProvider);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GnomeTile extends StatelessWidget {
  const _GnomeTile({required this.gnome});

  final Gnome gnome;

  @override
  Widget build(BuildContext context) {
    final subtitle = _buildSubtitle(gnome);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            Uri.encodeFull(gnome.thumbnail),
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 56,
                height: 56,
                color: Colors.black12,
                alignment: Alignment.center,
                child: const Icon(Icons.shield),
              );
            },
          ),
        ),
        title: Text(
          gnome.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            builder: (_) => _GnomeDetailsSheet(gnome: gnome),
          );
        },
      ),
    );
  }

  String _buildSubtitle(Gnome gnome) {
    final topProfessions = gnome.professions.take(2).join(', ');
    if (topProfessions.isEmpty) {
      return gnome.subtitle;
    }

    return '${gnome.subtitle} • $topProfessions';
  }
}

class _GnomeDetailsSheet extends StatelessWidget {
  const _GnomeDetailsSheet({required this.gnome});

  final Gnome gnome;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gnome.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FactChip(label: 'Age', value: '${gnome.age}'),
                _FactChip(label: 'Hair', value: gnome.hairColor),
                _FactChip(label: 'Height', value: gnome.height.toStringAsFixed(2)),
                _FactChip(label: 'Weight', value: gnome.weight.toStringAsFixed(2)),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Professions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              gnome.professions.isEmpty
                  ? 'No registered professions'
                  : gnome.professions.join(', '),
            ),
            const SizedBox(height: 18),
            Text(
              'Friends',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              gnome.friends.isEmpty
                  ? 'No friends listed'
                  : gnome.friends.join(', '),
            ),
          ],
        ),
      ),
    );
  }
}

class _FactChip extends StatelessWidget {
  const _FactChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
    );
  }
}
