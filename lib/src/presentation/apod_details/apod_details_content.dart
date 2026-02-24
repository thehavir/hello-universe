import 'package:flutter/material.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/components/fade_in_network_image.dart';

class ApodDetailsContent extends StatelessWidget {
  const ApodDetailsContent({
    required this.apod,
    required this.onApodTap,
    super.key,
  });

  final Apod apod;
  final VoidCallback onApodTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: apod.url,
            child: GestureDetector(
              onTap: onApodTap,
              child: Stack(
                alignment: .center,
                children: [
                  FadeInNetworkImage(url: apod.url),
                  if (apod.mediaType == .video)
                    Icon(
                      Icons.play_circle_outline,
                      color: theme.colorScheme.outline,
                      size: 100,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const .all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  apod.explanation,
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Copyright: ${apod.copyright?.split(';').first ?? 'PUBLIC'}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontStyle: .italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  apod.date.format(),
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontStyle: .italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
