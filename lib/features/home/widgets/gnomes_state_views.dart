import 'package:flutter/material.dart';
import 'package:gnome_challenge/core/network/domain/network_exception.dart';

class GnomesLoadingView extends StatelessWidget {
  const GnomesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class GnomesErrorView extends StatelessWidget {
  const GnomesErrorView({required this.error, required this.onRetry, super.key});

  final Object error;
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
              'Could not load gnomes.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              _messageForError(error),
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  String _messageForError(Object error) {
    if (error is NetworkException) {
      switch (error.type) {
        case NetworkExceptionType.connectionTimeout:
        case NetworkExceptionType.receiveTimeout:
        case NetworkExceptionType.sendTimeout:
          return 'The request timed out. Please check your connection and retry.';
        case NetworkExceptionType.connectionError:
          return 'No internet connection detected.';
        case NetworkExceptionType.badResponse:
          return 'Server error (${error.statusCode ?? 'unknown'}).';
        case NetworkExceptionType.cancel:
          return 'Request was cancelled.';
        case NetworkExceptionType.badCertificate:
          return 'Secure connection failed.';
        case NetworkExceptionType.unknown:
          return error.message;
      }
    }

    return 'Try again in a moment.';
  }
}

class GnomesEmptyView extends StatelessWidget {
  const GnomesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No gnomes found for this search.'));
  }
}
