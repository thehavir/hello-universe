import 'package:flutter/material.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';
import 'package:hello_universe/src/presentation/components/fade_in_network_image.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({required this.apod, required this.onApodTap, super.key});

  final Apod apod;
  final VoidCallback onApodTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                // Todo(Havir): handle videos that they have thumbnail.
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
