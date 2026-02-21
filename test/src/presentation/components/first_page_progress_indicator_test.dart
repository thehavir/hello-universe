import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/components/first_page_progress_indicator.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(FirstPageProgressIndicator), findsOneWidget);
  });

  testWidgets('has $CircularProgressIndicator', (tester) async {
    await tester.pumpTested();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: FirstPageProgressIndicator()));
}
