import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/components/no_more_item_indicator.dart';
import 'package:mockito/mockito.dart';

void main() {
  final textTheme = TextTheme.of(_MockContext());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(NoMoreItemsIndicator), findsOneWidget);
  });

  testWidgets('has text', (tester) async {
    await tester.pumpTested();

    expect(find.text('That was the last APOD! 👾'), findsOneWidget);
  });

  testWidgets('has has correct style', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(find.text('That was the last APOD! 👾'));
    expect(widget.style, textTheme.bodyLarge);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: NoMoreItemsIndicator()));
}

class _MockContext extends Mock implements BuildContext {}
