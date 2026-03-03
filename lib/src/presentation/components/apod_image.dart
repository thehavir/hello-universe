import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/assets.dart';

class ApodImage extends StatelessWidget {
  const ApodImage({
    required this.cacheManager,
    required this.height,
    this.url,
    this.fit = .fitWidth,
    super.key,
  });

  final CacheManager cacheManager;
  final String? url;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null || url.isEmpty) {
      return Image.asset(Assets.noImageIcon, height: height);
    }

    return CachedNetworkImage(
      cacheManager: cacheManager,
      imageUrl: url,
      fit: fit,
      width: .infinity,
      height: height,
      placeholder: (_, __) =>
          Image.asset(Assets.placeholder, fit: fit, height: height),
      errorWidget: (_, __, ___) =>
          Image.asset(Assets.noImageIcon, height: height),
    );
  }
}
