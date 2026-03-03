import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_content.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_cubit.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen_arguments.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';

class ApodDetailsScreen extends StatelessWidget {
  const ApodDetailsScreen({required this.apod, super.key});

  final Apod apod;

  @override
  Widget build(BuildContext context) => BlocProvider<ApodDetailsCubit>(
    create: (context) =>
        context.resolveWithParams<ApodDetailsCubit, Apod>(apod),
    child: _Consumer(
      apod: apod,
      uriLauncher: context.resolve(),
      cacheManager: context.resolve(),
    ),
  );
}

class _Consumer extends StatelessWidget {
  const _Consumer({
    required this.apod,
    required this.uriLauncher,
    required this.cacheManager,
  });

  final Apod apod;
  final UriLauncher uriLauncher;
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(apod.title)),
    body: BlocBuilder<ApodDetailsCubit, ApodDetailsState>(
      builder: (context, state) => ApodDetailsContent(
        apod: apod,
        cacheManager: cacheManager,
        onApodTap: state.isApodReady ? () => _onApodTap(context) : null,
      ),
    ),
  );

  void _onApodTap(BuildContext context) async {
    final url = apod.url;
    if (url == null || url.isEmpty) {
      _showSnackbar(context);
      return;
    }

    if (apod.mediaType == .video) {
      await uriLauncher.launch(Uri.parse(url));
    } else {
      await context.pushNamed(
        Routes.apodFullSizeScreen,
        extra: ApodFullSizeScreenArguments(url: url, date: apod.date),
      );
    }
  }

  void _showSnackbar(BuildContext context) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('No URL found for this APOD')));
}

extension on ApodDetailsState {
  bool get isApodReady => switch (this) {
    LoadingCubitState() || ErrorCubitState() => false,
    LoadedCubitState() => true,
  };
}
