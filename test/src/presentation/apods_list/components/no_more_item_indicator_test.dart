import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apods_list/components/no_more_item_indicator.dart';

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

    expect(find.byType(NoMoreItemsIndicator), findsOneWidget);
  });

  testWidgets('has text', (tester) async {
    await tester.pumpTested();

    expect(find.text('That was the last APOD! 👾'), findsOneWidget);
  });

  testWidgets('has has correct style', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<Text>(find.text('That was the last APOD! 👾'));
    expect(widget.style, theme.textTheme.bodyLarge);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: NoMoreItemsIndicator()));
}
