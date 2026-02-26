import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apods_list/components/apod_card.dart';
import 'package:hello_universe/src/presentation/components/fade_in_network_image.dart';

import '../../../../test_doubles/test_models.dart';
import '../../../../test_utils/mock_context.mocks.dart';

void main() {
  late MockBuildContext context;
  late ThemeData theme;

  setUp(() {
    context = MockBuildContext();
    theme = Theme.of(context);
  });

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodCard), findsOneWidget);
  });

  testWidgets('has $Card', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets('on $Card tap works', (tester) async {
    var isPressed = false;
    await tester.pumpTested(onApodTap: () => isPressed = true);

    await tester.tap(find.byType(Card));

    expect(isPressed, isTrue);
  });

  testWidgets('has a $Hero', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Hero), findsOneWidget);
  });

  testWidgets('$Hero has apod\'s url as tag', (tester) async {
    final apod = TestModels.apod(url: 'torproject.org');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Hero>(find.byType(Hero));
    expect(widget.tag, 'torproject.org');
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

  testWidgets('has a title as ${Apod}s title', (tester) async {
    final apod = TestModels.apod(title: 'Beautiful Moon');
    await tester.pumpTested(apod: apod);

    expect(find.text('Beautiful Moon'), findsOneWidget);
  });

  testWidgets('title has titleMedium style', (tester) async {
    final apod = TestModels.apod(title: 'Beautiful Moon');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('Beautiful Moon'));
    expect(widget.style, theme.textTheme.titleMedium);
  });

  testWidgets('title has ${TextOverflow.ellipsis}', (tester) async {
    final apod = TestModels.apod(title: 'Beautiful Moon');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('Beautiful Moon'));
    expect(widget.overflow, TextOverflow.ellipsis);
  });

  testWidgets('has formatted date as ${Apod}s date', (tester) async {
    final apod = TestModels.apod(date: DateTime(1999, 04, 19));
    await tester.pumpTested(apod: apod);

    expect(find.text('1999-04-19'), findsOneWidget);
  });

  testWidgets('date has titleMedium style', (tester) async {
    final apod = TestModels.apod(date: DateTime(1999, 04, 19));
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Text>(find.text('1999-04-19'));
    expect(widget.style, theme.textTheme.titleMedium);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({Apod? apod, VoidCallback? onApodTap}) => pumpWidget(
    MaterialApp(
      home: ApodCard(
        apod: apod ?? TestModels.apod(),
        onApodTap: onApodTap ?? () {},
      ),
    ),
  );
}
