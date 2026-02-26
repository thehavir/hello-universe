import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_content.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';

class ApodDetailsScreen extends StatelessWidget {
  const ApodDetailsScreen({required this.apod, super.key});

  final Apod apod;

  @override
  Widget build(BuildContext context) =>
      _Consumer(apod: apod, uriLauncher: context.resolve());
}

class _Consumer extends StatelessWidget {
  const _Consumer({required this.apod, required this.uriLauncher});

  final Apod apod;
  final UriLauncher uriLauncher;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(apod.title)),
    body: ApodDetailsContent(apod: apod, onApodTap: () => _onApodTap(context)),
  );

  void _onApodTap(BuildContext context) async {
    if (apod.mediaType == .video) {
      await uriLauncher.launch(Uri.parse(apod.url));
    } else {
      await context.pushNamed(Routes.apodFullSizeScreen, extra: apod.url);
    }
  }
}
