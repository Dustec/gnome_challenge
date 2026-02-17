import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';

class GnomeListTile extends StatelessWidget {
  const GnomeListTile({required this.gnome, super.key});

  final Gnome gnome;

  @override
  Widget build(BuildContext context) {
    final topProfessions = gnome.professions.take(2).join(', ');
    final subtitle =
        topProfessions.isEmpty
            ? gnome.subtitle
            : '${gnome.subtitle} • $topProfessions';

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: Uri.encodeFull(gnome.thumbnail),
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            placeholder: (_, __) => const _GnomeImagePlaceholder(),
            errorWidget: (_, __, ___) => const _GnomeImageFallback(),
          ),
        ),
        title: Text(gnome.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            builder: (_) => GnomeDetailsSheet(gnome: gnome),
          );
        },
      ),
    );
  }
}

class _GnomeImagePlaceholder extends StatelessWidget {
  const _GnomeImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      color: Colors.black12,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _GnomeImageFallback extends StatelessWidget {
  const _GnomeImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      color: Colors.black12,
      alignment: Alignment.center,
      child: const Icon(Icons.shield),
    );
  }
}

class GnomeDetailsSheet extends StatelessWidget {
  const GnomeDetailsSheet({required this.gnome, super.key});

  final Gnome gnome;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gnome.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FactChip(label: 'Age', value: '${gnome.age}'),
                FactChip(label: 'Hair', value: gnome.hairColor),
                FactChip(
                  label: 'Height',
                  value: gnome.height.toStringAsFixed(2),
                ),
                FactChip(
                  label: 'Weight',
                  value: gnome.weight.toStringAsFixed(2),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Professions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              gnome.professions.isEmpty
                  ? 'No registered professions'
                  : gnome.professions.join(', '),
            ),
            const SizedBox(height: 18),
            Text('Friends', style: Theme.of(context).textTheme.titleMedium),
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

class FactChip extends StatelessWidget {
  const FactChip({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text('$label: $value'));
  }
}
