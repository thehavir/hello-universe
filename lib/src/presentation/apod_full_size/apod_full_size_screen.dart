import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen_arguments.dart';
import 'package:hello_universe/src/presentation/apod_full_size/components/transparent_gradient_app_bar.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';

class ApodFullSizeScreen extends StatelessWidget {
  const ApodFullSizeScreen({required this.arguments, super.key});

  final ApodFullSizeScreenArguments arguments;

  @override
  Widget build(BuildContext context) =>
      _Consumer(arguments: arguments, cacheManager: context.resolve());
}

class _Consumer extends StatefulWidget {
  const _Consumer({required this.arguments, required this.cacheManager});

  final ApodFullSizeScreenArguments arguments;
  final CacheManager cacheManager;

  @override
  State<_Consumer> createState() => _ConsumerState();
}

class _ConsumerState extends State<_Consumer> {
  bool _showAppBar = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    extendBodyBehindAppBar: true,
    appBar: _showAppBar ? const TransparentGradientAppBar() : null,
    body: GestureDetector(
      onTap: () => setState(() => _showAppBar = !_showAppBar),
      child: ApodFullSizeContent(
        cacheManager: widget.cacheManager,
        url: widget.arguments.url,
        date: widget.arguments.date,
      ),
    ),
  );
}
