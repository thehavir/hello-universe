import 'package:flutter/material.dart';
import 'package:hello_universe/src/assets.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        const SizedBox(height: 64),
        Center(child: Image.asset(Assets.noResultIcon, height: 128)),
        const SizedBox(height: 64),
        Text('There is no APOD!', style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        Text('We could\'nt find any APOD!', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
