import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

import '../../../test_utils/mock_cache_manager.mocks.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodFullSizeContent), findsOneWidget);
  });

  testWidgets('has $Hero', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Hero), findsOneWidget);
  });

  testWidgets('$Hero has tag set to the passed date', (tester) async {
    final date = DateTime(1994);
    await tester.pumpTested(date: date);

    final widget = tester.widget<Hero>(find.byType(Hero));
    expect(widget.tag, date);
  });

  testWidgets('has $InteractiveViewer', (tester) async {
    await tester.pumpTested();

    expect(find.byType(InteractiveViewer), findsOneWidget);
  });

  testWidgets('$InteractiveViewer minScale is 1', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<InteractiveViewer>(
      find.byType(InteractiveViewer),
    );
    expect(widget.minScale, 1);
  });

  testWidgets('$InteractiveViewer maxScale is 5', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<InteractiveViewer>(
      find.byType(InteractiveViewer),
    );
    expect(widget.maxScale, 5);
  });

  testWidgets('has $ApodImage', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodImage), findsOneWidget);
  });

  testWidgets('passes url to the $ApodImage', (tester) async {
    const url = 'https://libreplanet.org/';
    await tester.pumpTested(url: url);

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.url, url);
  });

  testWidgets('passes height to the $ApodImage', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.height, double.infinity);
  });

  testWidgets('passes $CacheManager to the $ApodImage', (tester) async {
    final cacheManager = MockCacheManager();
    await tester.pumpTested(cacheManager: cacheManager);

    final widget = tester.widget<ApodImage>(find.byType(ApodImage));
    expect(widget.cacheManager, cacheManager);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({
    String? url,
    DateTime? date,
    CacheManager? cacheManager,
  }) => pumpWidget(
    MaterialApp(
      home: ApodFullSizeContent(
        url: url ?? 'url',
        date: date ?? DateTime(2020),
        cacheManager: cacheManager ?? MockCacheManager(),
      ),
    ),
  );
}
