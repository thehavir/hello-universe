import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

class ApodFullSizeContent extends StatelessWidget {
  const ApodFullSizeContent({
    required this.url,
    required this.cacheManager,
    super.key,
  });

  final String url;
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) => Hero(
    tag: url,
    child: Center(
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: ApodImage(
          cacheManager: cacheManager,
          url: url,
          height: .infinity,
        ),
      ),
    ),
  );
}
