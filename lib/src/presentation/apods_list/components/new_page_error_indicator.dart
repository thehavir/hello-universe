import 'package:flutter/material.dart';

class NewPageErrorIndicator extends StatelessWidget {
  const NewPageErrorIndicator({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) =>
      TextButton(onPressed: onRetry, child: const Text('Retry'));
}
