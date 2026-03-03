import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:provider/provider.dart';

import '../../../test_utils/mock_cache_manager.mocks.dart';

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

  testWidgets('passes $CacheManager to $ApodFullSizeContent', (tester) async {
    final cacheManager = MockCacheManager();
    await tester.pumpTested(cacheManager: cacheManager);

    final widget = tester.widget<ApodFullSizeContent>(
      find.byType(ApodFullSizeContent),
    );
    expect(widget.cacheManager, cacheManager);
  });
}

extension on WidgetTester {
  Future<void> pumpTested({String? url, CacheManager? cacheManager}) =>
      pumpWidget(
        Provider.value(
          value: InjectorDelegate(
            Injector([
              SingletonInjection<CacheManager>(
                (_) => cacheManager ?? MockCacheManager(),
              ),
            ]),
          ),
          child: MaterialApp(home: ApodFullSizeScreen(url: url ?? 'url')),
        ),
      );
}
