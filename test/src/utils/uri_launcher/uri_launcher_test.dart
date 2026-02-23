// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launch_mode.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'uri_launcher_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<UrlLauncherPlatform>()])
void main() {
  setUp(() {
    _builder = _ArrangeBuilder();
    UrlLauncherPlatform.instance = _builder.urlLauncher;
  });

  testWidgets('can be created', (tester) async {
    final tested = _builder.createTested();

    expect(tested, isA<UriLauncherImpl>());
  });

  group('on launch', () {
    testWidgets('calls launchUrl', (tester) async {
      final tested = _builder.createTested();

      await tested.launch(Uri.parse('url.com'));

      verify(_builder.urlLauncher.launchUrl(any, any)).called(1);
    });

    testWidgets('passes url to the launchUrl', (tester) async {
      const url = 'torproject.org';
      final tested = _builder.createTested();

      await tested.launch(Uri.parse(url));

      verify(_builder.urlLauncher.launchUrl(url, any)).called(1);
    });

    testWidgets('passes $UriLaunchMode to the launchUrl', (tester) async {
      final tested = _builder.createTested();

      await tested.launch(
        Uri.parse('url.com'),
        mode: .externalNonBrowserApplication,
      );

      final caputured =
          verify(
                _builder.urlLauncher.launchUrl(any, captureAny),
              ).captured.single
              as LaunchOptions;

      expect(caputured.mode, PreferredLaunchMode.externalNonBrowserApplication);
    });

    testWidgets('passes ${UriLaunchMode.externalApplication} to the launchUrl '
        'when it is null', (tester) async {
      final tested = _builder.createTested();

      await tested.launch(Uri.parse('url.com'), mode: null);

      final caputured =
          verify(
                _builder.urlLauncher.launchUrl(any, captureAny),
              ).captured.single
              as LaunchOptions;

      expect(caputured.mode, PreferredLaunchMode.externalApplication);
    });

    [true, false].forEach((isLanuched) {
      testWidgets('returns $isLanuched', (tester) async {
        when(
          _builder.urlLauncher.launchUrl(any, any),
        ).thenAnswer((_) async => isLanuched);
        final tested = _builder.createTested();

        final result = await tested.launch(Uri.parse('url.com'));

        expect(result, isLanuched);
      });
    });
  });
}

class _ArrangeBuilder {
  _ArrangeBuilder();

  final urlLauncher = MockUrlLauncherPlatformWithMixin();

  UriLauncher createTested() => UriLauncherImpl();
}

class MockUrlLauncherPlatformWithMixin extends MockUrlLauncherPlatform
    with MockPlatformInterfaceMixin {}
