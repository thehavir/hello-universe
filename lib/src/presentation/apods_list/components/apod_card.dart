import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({
    required this.apod,
    required this.onApodTap,
    required this.cacheManager,
    super.key,
  });

  final Apod apod;
  final VoidCallback onApodTap;
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isVideo = apod.mediaType == .video;

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: .all(.circular(8))),
      child: InkWell(
        onTap: onApodTap,
        child: Column(
          children: [
            Hero(
              tag: apod.url,
              child: ClipRRect(
                borderRadius: const .vertical(top: Radius.circular(8)),
                child: Stack(
                  alignment: .center,
                  children: [
                    ApodImage(
                      cacheManager: cacheManager,
                      url: isVideo ? apod.thumbnailUrl : apod.url,
                      height: 180,
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
              padding: const .all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      apod.title,
                      style: theme.textTheme.titleMedium,
                      overflow: .ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(apod.date.format(), style: theme.textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
