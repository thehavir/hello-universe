import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

class ApodDetailsContent extends StatelessWidget {
  const ApodDetailsContent({
    required this.apod,
    required this.cacheManager,
    required this.onApodTap,
    super.key,
  });

  final Apod apod;
  final CacheManager cacheManager;
  final VoidCallback? onApodTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isVideo = apod.mediaType == .video;

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
                  ApodImage(
                    cacheManager: cacheManager,
                    url: isVideo ? apod.thumbnailUrl : apod.url,
                    height: 360,
                    fit: .cover,
                  ),
                  if (isVideo)
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
