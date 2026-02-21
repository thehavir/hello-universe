import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/presentation/components/empty_content.dart';
import 'package:mockito/mockito.dart';

void main() {
  final textTheme = TextTheme.of(_MockContext());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(EmptyContent), findsOneWidget);
  });

  testWidgets('has ${Assets.noResultIcon} as $Image', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Image>(find.byType(Image));
    final imageProvider = widget.image as AssetImage;
    expect(imageProvider.assetName, Assets.noResultIcon);
  });

  testWidgets('has title', (tester) async {
    await tester.pumpTested();

    expect(find.text('There is no APOD!'), findsOneWidget);
  });

  testWidgets('has titleLarge', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(find.text('There is no APOD!'));
    expect(widget.style, textTheme.titleLarge);
  });

  testWidgets('has subtitle', (tester) async {
    await tester.pumpTested();

    expect(find.text('We could\'nt find any APOD!'), findsOneWidget);
  });

  testWidgets('has bodyMedium', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(
      find.text('We could\'nt find any APOD!'),
    );
    expect(widget.style, textTheme.bodyMedium);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: EmptyContent()));
}

class _MockContext extends Mock implements BuildContext {}
