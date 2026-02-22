import 'package:flutter/material.dart';
import 'package:hello_universe/src/assets.dart';

class ErrorContent extends StatelessWidget {
  const ErrorContent({required this.error, required this.onRetry, super.key});

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const SizedBox(height: 64),
              Center(child: Image.asset(Assets.errorIcon, height: 128)),
              const SizedBox(height: 64),
              Text('Something went wrong', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              Text(
                'Failed to load! Please try again\nError: $error',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 56,
          width: .infinity,
          child: ElevatedButton(
            onPressed: onRetry,
            child: const Text('Try again'),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
