// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_content.dart';
import 'package:hello_universe/src/presentation/components/fade_in_network_image.dart';
import 'package:mockito/mockito.dart';

import '../../../test_doubles/test_models.dart';

void main() {
  final context = _MockContext();
  final theme = Theme.of(context);

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodDetailsContent), findsOneWidget);
  });

  testWidgets('has $SingleChildScrollView', (tester) async {
    await tester.pumpTested();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('has $Hero', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Hero), findsOneWidget);
  });

  testWidgets('$Hero has apod\'s url as tag', (tester) async {
    final apod = TestModels.apod(url: 'torproject.org');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Hero>(find.byType(Hero));
    expect(widget.tag, 'torproject.org');
  });

  testWidgets('on $Hero tap calls onApodTap', (tester) async {
    var isPressed = false;
    await tester.pumpTested(onApodTap: () => isPressed = true);

    await tester.tap(find.byType(Hero));
    expect(isPressed, isTrue);
  });

  testWidgets('has a $FadeInNetworkImage', (tester) async {
    await tester.pumpTested();

    expect(find.byType(FadeInNetworkImage), findsOneWidget);
  });

  testWidgets('passes ${Apod}s url to the $FadeInNetworkImage', (tester) async {
    final apod = TestModels.apod(url: 'tor.org');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<FadeInNetworkImage>(
      find.byType(FadeInNetworkImage),
    );
    expect(widget.url, 'tor.org');
  });

  group('when $MediaType is ${MediaType.video}', () {
    testWidgets('has play_circle_outline icon on top of $FadeInNetworkImage ', (
      tester,
    ) async {
      final apod = TestModels.apod(mediaType: .video);
      await tester.pumpTested(apod: apod);

      final widget = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(widget.children, [
        isA<FadeInNetworkImage>(),
        isA<Icon>().having((p) => p.icon, 'icon', Icons.play_circle_outline),
      ]);
    });

    testWidgets('play_circle_outline icon has outline color ', (tester) async {
      final apod = TestModels.apod(mediaType: .video);
      await tester.pumpTested(apod: apod);

      final widget = tester.widget<Icon>(
        find.byIcon(Icons.play_circle_outline),
      );
      expect(widget.color, theme.colorScheme.outline);
    });

    testWidgets('play_circle_outline icon has correct size ', (tester) async {
      final apod = TestModels.apod(mediaType: .video);
      await tester.pumpTested(apod: apod);

      final widget = tester.widget<Icon>(
        find.byIcon(Icons.play_circle_outline),
      );
      expect(widget.size, 100);
    });
  });

  <MediaType>[.image, .other].forEach((type) {
    testWidgets('does not have play_circle_outline icon '
        'when $MediaType is $type', (tester) async {
      final apod = TestModels.apod(mediaType: type);
      await tester.pumpTested(apod: apod);

      final widget = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(widget.children, [isA<FadeInNetworkImage>()]);
    });
  });

  testWidgets('has explanation', (tester) async {
    final apod = TestModels.apod(explanation: 'Blue Earth');
    await tester.pumpTested(apod: apod);

    expect(find.text('Blue Earth'), findsOneWidget);
  });

  testWidgets('explanation has bodyLarge text theme', (tester) async {
    final apod = TestModels.apod(explanation: 'Blue Earth');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text(apod.explanation));
    expect(widget.style, theme.textTheme.bodyLarge);
  });

  testWidgets('explanation has onSurface color', (tester) async {
    final apod = TestModels.apod(explanation: 'Blue Earth');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text(apod.explanation));
    expect(widget.style?.color, theme.colorScheme.onSurface);
  });

  testWidgets('shows whole copyright '
      'when it does not have semicolon', (tester) async {
    final apod = TestModels.apod(copyright: 'CC-BY');
    await tester.pumpTested(apod: apod);

    expect(find.text('Copyright: CC-BY'), findsOneWidget);
  });

  testWidgets('shows part of copyright before semicolon '
      'when it does not have semicolon', (tester) async {
    final apod = TestModels.apod(copyright: 'CC-BY; extra data');
    await tester.pumpTested(apod: apod);

    expect(find.text('Copyright: CC-BY'), findsOneWidget);
  });

  testWidgets('shows PUBLIC as copyright when it is null', (tester) async {
    final apod = TestModels.apod(copyright: null);
    await tester.pumpTested(apod: apod);

    expect(find.text('Copyright: PUBLIC'), findsOneWidget);
  });

  testWidgets('copyright has bodyLarge text theme with ${FontStyle.italic}', (
    tester,
  ) async {
    final apod = TestModels.apod(copyright: 'CC-BY');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('Copyright: CC-BY'));
    expect(
      widget.style,
      theme.textTheme.bodyLarge?.copyWith(fontStyle: .italic),
    );
  });

  testWidgets('copyright has onSurface color', (tester) async {
    final apod = TestModels.apod(copyright: 'CC-BY');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('Copyright: CC-BY'));
    expect(widget.style?.color, theme.colorScheme.onSurface);
  });

  testWidgets('has formatted date', (tester) async {
    final apod = TestModels.apod(date: DateTime(2040, 4, 7, 11, 34));
    await tester.pumpTested(apod: apod);

    expect(find.text('2040-04-07'), findsOneWidget);
  });

  testWidgets('date has bodyLarge text theme with ${FontStyle.italic}', (
    tester,
  ) async {
    final apod = TestModels.apod(date: DateTime(2040, 4, 7));
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('2040-04-07'));
    expect(
      widget.style,
      theme.textTheme.bodyLarge?.copyWith(fontStyle: .italic),
    );
  });

  testWidgets('date has onSurface color', (tester) async {
    final apod = TestModels.apod(date: DateTime(2040, 4, 7));
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('2040-04-07'));
    expect(widget.style?.color, theme.colorScheme.onSurface);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({Apod? apod, VoidCallback? onApodTap}) => pumpWidget(
    MaterialApp(
      home: ApodDetailsContent(
        apod: apod ?? TestModels.apod(),
        onApodTap: onApodTap ?? () {},
      ),
    ),
  );
}

class _MockContext extends Mock implements BuildContext {}
