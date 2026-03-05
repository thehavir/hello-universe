import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apod_full_size/components/transparent_gradient_app_bar.dart';

void main() {
  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(TransparentGradientAppBar), findsOneWidget);
  });

  testWidgets('implements $PreferredSizeWidget', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<TransparentGradientAppBar>(
      find.byType(TransparentGradientAppBar),
    );
    expect(widget, isA<PreferredSizeWidget>());
  });

  testWidgets('has correct preferredSize', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<TransparentGradientAppBar>(
      find.byType(TransparentGradientAppBar),
    );
    expect(widget.preferredSize, const Size.fromHeight(kToolbarHeight));
  });

  testWidgets('has $AppBar', (tester) async {
    await tester.pumpTested();

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('$AppBar has transparent backgroundColor', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<AppBar>(find.byType(AppBar));
    expect(widget.backgroundColor, Colors.transparent);
  });

  testWidgets('$AppBar has zero elevation', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<AppBar>(find.byType(AppBar));
    expect(widget.elevation, 0);
  });

  testWidgets('$AppBar has ${SystemUiOverlayStyle.light}', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<AppBar>(find.byType(AppBar));
    expect(widget.systemOverlayStyle, SystemUiOverlayStyle.light);
  });

  testWidgets('$AppBar has $BackButton', (tester) async {
    await tester.pumpTested();

    expect(find.byType(BackButton), findsOneWidget);
  });

  testWidgets('$BackButton has white color', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<BackButton>(find.byType(BackButton));
    expect(widget.color, Colors.white);
  });

  testWidgets('$AppBar has flexibleSpace with $Container', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<AppBar>(find.byType(AppBar));
    expect(widget.flexibleSpace, isA<Container>());
  });

  testWidgets('flexibleSpace $Container has $BoxDecoration', (tester) async {
    await tester.pumpTested();

    final widget =
        tester.widget<AppBar>(find.byType(AppBar)).flexibleSpace as Container;
    expect(widget.decoration, isA<BoxDecoration>());
  });

  testWidgets('$BoxDecoration has $LinearGradient', (tester) async {
    await tester.pumpTested();

    final widget =
        tester.widget<AppBar>(find.byType(AppBar)).flexibleSpace as Container;
    final decoration = widget.decoration as BoxDecoration;
    expect(decoration.gradient, isA<LinearGradient>());
  });

  testWidgets('$LinearGradient begins at topCenter', (tester) async {
    await tester.pumpTested();

    final container =
        tester.widget<AppBar>(find.byType(AppBar)).flexibleSpace as Container;
    final decoration = container.decoration! as BoxDecoration;
    final widget = decoration.gradient! as LinearGradient;
    expect(widget.begin, Alignment.topCenter);
  });

  testWidgets('$LinearGradient ends at bottomCenter', (tester) async {
    await tester.pumpTested();

    final container =
        tester.widget<AppBar>(find.byType(AppBar)).flexibleSpace as Container;
    final decoration = container.decoration! as BoxDecoration;
    final widget = decoration.gradient! as LinearGradient;
    expect(widget.end, Alignment.bottomCenter);
  });

  testWidgets('$LinearGradient has correct colors', (tester) async {
    await tester.pumpTested();

    final container =
        tester.widget<AppBar>(find.byType(AppBar)).flexibleSpace as Container;
    final decoration = container.decoration! as BoxDecoration;
    final widget = decoration.gradient! as LinearGradient;
    expect(widget.colors, [Colors.black54, Colors.transparent]);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() =>
      pumpWidget(const MaterialApp(home: TransparentGradientAppBar()));
}
