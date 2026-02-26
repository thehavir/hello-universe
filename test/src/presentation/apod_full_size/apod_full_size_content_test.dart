import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodFullSizeContent), findsOneWidget);
  });

  testWidgets('has $Hero', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Hero), findsOneWidget);
  });

  testWidgets('$Hero has tag set to the passed url', (tester) async {
    const url = 'tor-project.org';
    await tester.pumpTested(url: url);

    final widget = tester.widget<Hero>(find.byType(Hero));
    expect(widget.tag, url);
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

  testWidgets('has $Image', (tester) async {
    await tester.pumpTested();

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('$Image has ${double.infinity} width', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Image>(find.byType(Image));
    expect(widget.width, double.infinity);
  });

  testWidgets('$Image has ${double.infinity} height', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Image>(find.byType(Image));
    expect(widget.height, double.infinity);
  });

  testWidgets('$Image has ${BoxFit.fitWidth}', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Image>(find.byType(Image));
    expect(widget.fit, BoxFit.fitWidth);
  });

  testWidgets('$Image has $NetworkImage as provider', (tester) async {
    await tester.pumpTested();

    final provider = tester.widget<Image>(find.byType(Image)).image;
    expect(provider, isA<NetworkImage>());
  });

  testWidgets('$NetworkImage has passed url', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final provider =
        tester.widget<Image>(find.byType(Image)).image as NetworkImage;
    expect(provider.url, url);
  });

  testWidgets('has error image', (tester) async {
    await tester.pumpTested();

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final image = tester.widgetList<Image>(widgetFinder).first;
    final errorImage = image.errorBuilder!(context, 'error', .current) as Image;

    expect(errorImage, isA<Image>());
  });

  testWidgets('error image has ${Assets.noImageIcon}', (tester) async {
    await tester.pumpTested();

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final image = tester.widgetList<Image>(widgetFinder).first;
    final errorImage = image.errorBuilder!(context, 'error', .current) as Image;
    final errorImageProvider = errorImage.image as AssetImage;

    expect(errorImageProvider.assetName, Assets.noImageIcon);
  });

  testWidgets('error image has ${BoxFit.contain}', (tester) async {
    await tester.pumpTested();

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final image = tester.widgetList<Image>(widgetFinder).first;
    final errorImage = image.errorBuilder!(context, 'error', .current) as Image;

    expect(errorImage.fit, BoxFit.contain);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({String? url}) =>
      pumpWidget(MaterialApp(home: ApodFullSizeContent(url: url ?? 'url')));
}
