import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/presentation/components/apod_image.dart';

import '../apod_details/apod_details_cubit_test.mocks.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodImage), findsOneWidget);
  });

  testWidgets('has $CachedNetworkImage', (tester) async {
    await tester.pumpTested();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('passes url to the $CachedNetworkImage', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widget = tester
        .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .first;
    expect(widget.imageUrl, 'fsf.org');
  });

  testWidgets('passes $CacheManager to the $CachedNetworkImage', (
    tester,
  ) async {
    final cacheManager = MockCacheManager();
    await tester.pumpTested(cacheManager: cacheManager);

    final widget = tester
        .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .first;
    expect(widget.cacheManager, cacheManager);
  });

  testWidgets('$CachedNetworkImage has passed $BoxFit', (tester) async {
    const fit = BoxFit.scaleDown;
    await tester.pumpTested(fit: fit);

    final widget = tester
        .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .first;
    expect(widget.fit, fit);
  });

  testWidgets('$CachedNetworkImage has passed hight', (tester) async {
    const height = 44.10;
    await tester.pumpTested(height: height);

    final widget = tester
        .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .first;
    expect(widget.height, height);
  });

  testWidgets('$CachedNetworkImage has width as ${double.infinity}', (
    tester,
  ) async {
    await tester.pumpTested();

    final widget = tester
        .widgetList<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .first;
    expect(widget.width, double.infinity);
  });

  testWidgets('$CachedNetworkImage has placeholder as $Image', (tester) async {
    await tester.pumpTested();

    final widget = tester.findCachedNetworkImagePlaceholder();
    expect(widget.image, isA<AssetImage>());
  });

  testWidgets('placeholder has ${Assets.placeholder}', (tester) async {
    await tester.pumpTested();

    final widget =
        tester.findCachedNetworkImagePlaceholder().image as AssetImage;
    expect(widget.assetName, Assets.placeholder);
  });

  testWidgets('placeholder has passed height', (tester) async {
    const height = 64.83;
    await tester.pumpTested(height: height);

    final widget = tester.findCachedNetworkImagePlaceholder();
    expect(widget.height, height);
  });

  testWidgets('placeholder has passed $BoxFit', (tester) async {
    const fit = BoxFit.contain;
    await tester.pumpTested(fit: fit);

    final widget = tester.findCachedNetworkImagePlaceholder();
    expect(widget.fit, fit);
  });

  testWidgets('$CachedNetworkImage has errorWidget as $Image', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widget = tester.findCachedNetworkImageErrorWidget();
    expect(widget.image, isA<AssetImage>());
  });

  testWidgets('errorWidget has ${Assets.noImageIcon}', (tester) async {
    await tester.pumpTested();

    final widget =
        tester.findCachedNetworkImageErrorWidget().image as AssetImage;
    expect(widget.assetName, Assets.noImageIcon);
  });

  testWidgets('errorWidget has passed height', (tester) async {
    const height = 415.77;
    await tester.pumpTested(height: height);

    final widget = tester.findCachedNetworkImageErrorWidget();
    expect(widget.height, height);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({
    CacheManager? cacheManager,
    String? url,
    double? height,
    BoxFit? fit,
  }) => pumpWidget(
    MaterialApp(
      home: ApodImage(
        cacheManager: cacheManager ?? MockCacheManager(),
        url: url ?? 'url',
        height: height ?? 100,
        fit: fit ?? .fitWidth,
      ),
    ),
  );

  Image findCachedNetworkImagePlaceholder() {
    final widgetFinder = find.byType(CachedNetworkImage);
    final context = widgetFinder.evaluate().first as BuildContext;
    final cachedNetworkImage = widgetList<CachedNetworkImage>(
      widgetFinder,
    ).first;
    return cachedNetworkImage.placeholder!(context, '') as Image;
  }

  Image findCachedNetworkImageErrorWidget() {
    final widgetFinder = find.byType(CachedNetworkImage);
    final context = widgetFinder.evaluate().first as BuildContext;
    final cachedNetworkImage = widgetList<CachedNetworkImage>(
      widgetFinder,
    ).first;
    return cachedNetworkImage.errorWidget!(context, '', Null) as Image;
  }
}
