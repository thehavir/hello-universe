import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apods_list/components/new_page_error_indicator.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(NewPageErrorIndicator), findsOneWidget);
  });

  testWidgets('has $TextButton', (tester) async {
    await tester.pumpTested();

    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('$TextButton onRetry works', (tester) async {
    var isPressed = false;
    await tester.pumpTested(onRetry: () => isPressed = true);

    await tester.tap(find.byType(TextButton));

    expect(isPressed, isTrue);
  });

  testWidgets('$TextButton has text', (tester) async {
    await tester.pumpTested();

    expect(find.text('Retry'), findsOneWidget);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({VoidCallback? onRetry}) => pumpWidget(
    MaterialApp(home: NewPageErrorIndicator(onRetry: onRetry ?? () {})),
  );
}
