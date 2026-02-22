import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apods_list/components/bottom_loader.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(BottomLoader), findsOneWidget);
  });

  testWidgets('has $CircularProgressIndicator', (tester) async {
    await tester.pumpTested();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: BottomLoader()));
}
