import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode.dart';
import 'package:url_launcher/url_launcher.dart';

extension UriLaunchModeExt on UriLaunchMode {
  LaunchMode get toPlatform {
    switch (this) {
      case .platformDefault:
        return .platformDefault;
      case .inAppWebView:
        return .inAppWebView;
      case .inAppBrowserView:
        return .inAppBrowserView;
      case .externalApplication:
        return .externalApplication;
      case .externalNonBrowserApplication:
        return .externalNonBrowserApplication;
    }
  }
}
