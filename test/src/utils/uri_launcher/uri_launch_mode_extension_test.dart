import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode_extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  <UriLaunchMode, LaunchMode>{
    .platformDefault: .platformDefault,
    .inAppWebView: .inAppWebView,
    .inAppBrowserView: .inAppBrowserView,
    .externalApplication: .externalApplication,
    .externalNonBrowserApplication: .externalNonBrowserApplication,
  }.forEach((localMode, platformMode) {
    testWidgets('toPlatform maps $localMode to $platformMode', (tester) async {
      expect(localMode.toPlatform, platformMode);
    });
  });
}
