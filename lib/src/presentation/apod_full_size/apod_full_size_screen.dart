import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';

class ApodFullSizeScreen extends StatelessWidget {
  const ApodFullSizeScreen({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) =>
      _Consumer(url: url, cacheManager: context.resolve());
}

class _Consumer extends StatelessWidget {
  const _Consumer({required this.url, required this.cacheManager});

  final String url;
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: ApodFullSizeContent(cacheManager: cacheManager, url: url),
  );
}
