import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/presentation/components/fade_in_network_image.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(FadeInNetworkImage), findsOneWidget);
  });

  testWidgets('has $NetworkImage', (tester) async {
    await tester.pumpTested();

    final widget = tester.widgetList<Image>(find.byType(Image)).first;
    expect(widget.image, isA<NetworkImage>());
  });

  testWidgets('$NetworkImage has url', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widget = tester.widgetList<Image>(find.byType(Image)).first;
    final imageProvider = widget.image as NetworkImage;
    expect(imageProvider.url, 'fsf.org');
  });

  testWidgets('$NetworkImage has ${BoxFit.cover}', (tester) async {
    await tester.pumpTested();

    final widget = tester.widgetList<Image>(find.byType(Image)).first;
    expect(widget.fit, BoxFit.cover);
  });

  testWidgets('$NetworkImage has hight', (tester) async {
    await tester.pumpTested();

    final widget = tester.widgetList<Image>(find.byType(Image)).first;
    expect(widget.height, 210);
  });

  testWidgets('$NetworkImage has ${Assets.placeholder}', (tester) async {
    await tester.pumpTested();

    final widget = tester.widgetList<Image>(find.byType(Image)).last;

    final imageProvider = widget.image as AssetImage;
    expect(imageProvider.assetName, Assets.placeholder);
  });

  testWidgets('${NetworkImage}s placeholder has ${BoxFit.cover}', (
    tester,
  ) async {
    await tester.pumpTested();

    final widget = tester.widgetList<Image>(find.byType(Image)).last;
    expect(widget.fit, BoxFit.cover);
  });

  testWidgets('$NetworkImage has ${Assets.noImageIcon} as ImageErrorBuilder', (
    tester,
  ) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final errorImageWidget = tester.widgetList<Image>(widgetFinder).first;
    final errorImage =
        errorImageWidget.errorBuilder!(context, url, .current) as Image;

    expect(errorImage.image, isA<AssetImage>());
  });

  testWidgets('ImageErrorBuilder has ${Assets.noImageIcon}', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final errorImageWidget = tester.widgetList<Image>(widgetFinder).first;
    final errorImage =
        errorImageWidget.errorBuilder!(context, url, .current) as Image;

    expect(
      errorImage.image,
      isA<AssetImage>().having(
        (p) => p.assetName,
        'assetName',
        Assets.noImageIcon,
      ),
    );
  });

  testWidgets('ImageErrorBuilder has ${BoxFit.cover}', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final errorImageWidget = tester.widgetList<Image>(widgetFinder).first;
    final errorImage =
        errorImageWidget.errorBuilder!(context, url, .current) as Image;

    expect(errorImage.fit, BoxFit.cover);
  });

  testWidgets('ImageErrorBuilder has hieght', (tester) async {
    const url = 'fsf.org';
    await tester.pumpTested(url: url);

    final widgetFinder = find.byType(Image);
    final context = widgetFinder.evaluate().first as BuildContext;
    final errorImageWidget = tester.widgetList<Image>(widgetFinder).first;
    final errorImage =
        errorImageWidget.errorBuilder!(context, url, .current) as Image;

    expect(errorImage.height, 210);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({String? url}) =>
      pumpWidget(MaterialApp(home: FadeInNetworkImage(url: url ?? 'url')));
}
