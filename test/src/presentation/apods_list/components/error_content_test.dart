// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/presentation/apods_list/components/error_content.dart';

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

    expect(find.byType(ErrorContent), findsOneWidget);
  });

  testWidgets('has ${Assets.errorIcon} as $Image', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Image>(find.byType(Image));
    final imageProvider = widget.image as AssetImage;
    expect(imageProvider.assetName, Assets.errorIcon);
  });

  testWidgets('has title', (tester) async {
    await tester.pumpTested();

    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('has titleLarge', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(find.text('Something went wrong'));
    expect(widget.style, theme.textTheme.titleLarge);
  });

  testWidgets('has subtitle when error is null', (tester) async {
    await tester.pumpTested(error: null);

    expect(
      find.text('Failed to load! Please try again\nError: null'),
      findsOneWidget,
    );
  });

  testWidgets('has subtitle when error is not null', (tester) async {
    const error = 'xx-33';
    await tester.pumpTested(error: error);

    expect(
      find.text('Failed to load! Please try again\nError: xx-33'),
      findsOneWidget,
    );
  });

  testWidgets('has bodyMedium', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(
      find.text('Failed to load! Please try again\nError: null'),
    );
    expect(widget.style, theme.textTheme.bodyMedium);
  });

  testWidgets('has $ElevatedButton', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('$ElevatedButton has title', (tester) async {
    await tester.pumpTested();

    expect(
      find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.text('Try again'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('$ElevatedButton works', (tester) async {
    var isPressed = false;
    await tester.pumpTested(onRetry: () => isPressed = true);

    await tester.tap(find.text('Try again'));

    expect(isPressed, isTrue);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({VoidCallback? onRetry, Object? error}) => pumpWidget(
    MaterialApp(
      home: ErrorContent(onRetry: onRetry ?? () {}, error: error),
    ),
  );
}
