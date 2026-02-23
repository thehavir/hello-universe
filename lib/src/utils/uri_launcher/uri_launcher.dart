import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode_extension.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class UriLauncher {
  Future<bool> launch(Uri uri, {UriLaunchMode? mode});
}

class UriLauncherImpl implements UriLauncher {
  @override
  Future<bool> launch(Uri uri, {UriLaunchMode? mode}) =>
      launchUrl(uri, mode: mode?.toPlatform ?? .externalApplication);
}
