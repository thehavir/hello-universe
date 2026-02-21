import 'package:flutter/material.dart';

class NoMoreItemsIndicator extends StatelessWidget {
  const NoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .all(8),
      child: Center(
        child: Text(
          'That was the last APOD! 👾',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
