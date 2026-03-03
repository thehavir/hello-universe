import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apods_list/components/apod_card.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

import '../../../../test_doubles/test_models.dart';
import '../../../../test_utils/mock_cache_manager.mocks.dart';
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

  testWidgets('$Hero has apod\'s date as tag', (tester) async {
    final date = DateTime(1920);
    final apod = TestModels.apod(date: date);
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<Hero>(find.byType(Hero));
    expect(widget.tag, date);
  });

  testWidgets('has a $ApodImage', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodImage), findsOneWidget);
  });

  testWidgets('passes ${Apod}s url to the $ApodImage', (tester) async {
    final apod = TestModels.apod(url: 'tor.org');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.url, 'tor.org');
  });

  testWidgets('passes height as 180 to the $ApodImage', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.height, 180);
  });

  testWidgets('passes $CacheManager to the $ApodImage', (tester) async {
    final cacheManager = MockCacheManager();
    await tester.pumpTested(cacheManager: cacheManager);

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.cacheManager, cacheManager);
  });

  group('when $MediaType is ${MediaType.video}', () {
    testWidgets('has play_circle_outline icon on top of $ApodImage ', (
      tester,
    ) async {
      final apod = TestModels.apod(mediaType: .video);
      await tester.pumpTested(apod: apod);

      final widget = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(widget.children, [
        isA<ApodImage>(),
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

    testWidgets('passes thumbnailUrl to the $ApodImage', (tester) async {
      const thumbnailUrl = 'https://duckduckgo.com/';
      final apod = TestModels.apod(
        mediaType: .video,
        thumbnailUrl: thumbnailUrl,
      );
      await tester.pumpTested(apod: apod);

      final widget = tester.widget<ApodImage>(find.byType(ApodImage));
      expect(widget.url, thumbnailUrl);
    });
  });

  <MediaType>[.image, .other].forEach((type) {
    testWidgets('does not have play_circle_outline icon '
        'when $MediaType is $type', (tester) async {
      final apod = TestModels.apod(mediaType: type);
      await tester.pumpTested(apod: apod);

      final widget = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(widget.children, [isA<ApodImage>()]);
    });

    testWidgets('passes url to the $ApodImage '
        'when $MediaType is $type', (tester) async {
      const url = 'https://duckduckgo.com/';
      final apod = TestModels.apod(mediaType: type, url: url);
      await tester.pumpTested(apod: apod);

      final widget = tester.widget<ApodImage>(find.byType(ApodImage));
      expect(widget.url, url);
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
  Future<void> pumpTested({
    Apod? apod,
    VoidCallback? onApodTap,
    CacheManager? cacheManager,
  }) => pumpWidget(
    MaterialApp(
      home: ApodCard(
        cacheManager: cacheManager ?? MockCacheManager(),
        apod: apod ?? TestModels.apod(),
        onApodTap: onApodTap ?? () {},
      ),
    ),
  );
}
