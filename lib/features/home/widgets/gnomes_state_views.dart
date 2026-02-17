import 'package:flutter/material.dart';

class GnomesLoadingView extends StatelessWidget {
  const GnomesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class GnomesErrorView extends StatelessWidget {
  const GnomesErrorView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
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
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class GnomesEmptyView extends StatelessWidget {
  const GnomesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No gnomes found for this search.'));
  }
}
