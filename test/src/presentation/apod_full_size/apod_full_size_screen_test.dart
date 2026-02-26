import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodFullSizeScreen), findsOneWidget);
  });

  testWidgets('has $Scaffold with ${Colors.black} backgroundColor', (
    tester,
  ) async {
    await tester.pumpTested();

    final widget = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(widget.backgroundColor, Colors.black);
  });

  testWidgets('has $ApodFullSizeContent', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodFullSizeContent), findsOneWidget);
  });

  testWidgets('passes url to $ApodFullSizeContent', (tester) async {
    const url = 'eff.org';
    await tester.pumpTested(url: url);

    final widget = tester.widget<ApodFullSizeContent>(
      find.byType(ApodFullSizeContent),
    );
    expect(widget.url, url);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({String? url}) =>
      pumpWidget(MaterialApp(home: ApodFullSizeScreen(url: url ?? 'url')));
}
