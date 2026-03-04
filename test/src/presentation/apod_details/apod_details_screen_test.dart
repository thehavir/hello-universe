// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/domain/entities/media_type.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_content.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_cubit.dart';
import 'package:hello_universe/src/presentation/apod_details/apod_details_screen.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_screen_arguments.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/cubit_state.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/uri_launcher/uri_launcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../test_doubles/test_models.dart';
import '../../../test_utils/mock_cache_manager.mocks.dart';
import '../../../test_utils/mock_go_router_provider.dart';
import 'apod_details_screen_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([
  MockSpec<UriLauncher>(),
  MockSpec<GoRouter>(),
  MockSpec<ApodDetailsCubit>(),
])
void main() {
  provideDummy<CubitState<void, Object>>(
    const LoadingCubitState<void, Object>(),
  );

  setUp(() => _builder = _ArrangeBuilder());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodDetailsScreen), findsOneWidget);
  });

  testWidgets('has $AppBar', (tester) async {
    await tester.pumpTested();

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('$AppBar has Apod\'s title', (tester) async {
    final apod = TestModels.apod(title: 'Martian');
    await tester.pumpTested(apod: apod);

    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Martian')),
      findsOneWidget,
    );
  });

  testWidgets('has $ApodDetailsContent', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodDetailsContent), findsOneWidget);
  });

  testWidgets('passes Apod to the $ApodDetailsContent', (tester) async {
    final apod = TestModels.apod(title: 'Orion belt');
    await tester.pumpTested(apod: apod);

    final widget = tester.widget<ApodDetailsContent>(
      find.byType(ApodDetailsContent),
    );
    expect(widget.apod, apod);
  });

  testWidgets('passes $CacheManager to the $ApodDetailsContent', (
    tester,
  ) async {
    final cacheManager = MockCacheManager();
    await tester.pumpTested(cacheManager: cacheManager);

    final widget = tester.widget<ApodDetailsContent>(
      find.byType(ApodDetailsContent),
    );
    expect(widget.cacheManager, cacheManager);
  });

  group('onApodTap', () {
    testWidgets('is null when $ApodDetailsCubit state is $LoadingCubitState', (
      tester,
    ) async {
      _builder.withApodDetailsCubitState(state: const LoadingCubitState());

      await tester.pumpTested();

      final widget = tester.widget<ApodDetailsContent>(
        find.byType(ApodDetailsContent),
      );
      expect(widget.onApodTap, isNull);
    });

    testWidgets('is null when $ApodDetailsCubit state is $ErrorCubitState', (
      tester,
    ) async {
      _builder.withApodDetailsCubitState(state: const ErrorCubitState('error'));

      await tester.pumpTested();

      final widget = tester.widget<ApodDetailsContent>(
        find.byType(ApodDetailsContent),
      );
      expect(widget.onApodTap, isNull);
    });

    group('when $ApodDetailsCubit state is $LoadedCubitState', () {
      group('when ${Apod}s url is null', () {
        testWidgets('shows $SnackBar', (tester) async {
          _builder.withApodDetailsCubitState(
            state: const LoadedCubitState(null),
          );
          final apod = TestModels.apod(url: null);
          await tester.pumpTested(apod: apod);

          tester
              .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
              .onApodTap!();
          await tester.pump();

          expect(find.byType(SnackBar), findsOneWidget);
        });

        testWidgets('$SnackBar has title', (tester) async {
          _builder.withApodDetailsCubitState(
            state: const LoadedCubitState(null),
          );
          final apod = TestModels.apod(url: null);
          await tester.pumpTested(apod: apod);

          tester
              .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
              .onApodTap!();
          await tester.pump();

          expect(
            find.descendant(
              of: find.byType(SnackBar),
              matching: find.text('No URL found for this APOD'),
            ),
            findsOneWidget,
          );
        });
      });

      group('when ${Apod}s url is empty', () {
        testWidgets('shows $SnackBar', (tester) async {
          _builder.withApodDetailsCubitState(
            state: const LoadedCubitState(null),
          );
          final apod = TestModels.apod(url: '');
          await tester.pumpTested(apod: apod);

          tester
              .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
              .onApodTap!();
          await tester.pump();

          expect(find.byType(SnackBar), findsOneWidget);
        });

        testWidgets('$SnackBar has title', (tester) async {
          _builder.withApodDetailsCubitState(
            state: const LoadedCubitState(null),
          );
          final apod = TestModels.apod(url: '');
          await tester.pumpTested(apod: apod);

          tester
              .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
              .onApodTap!();
          await tester.pump();

          expect(
            find.descendant(
              of: find.byType(SnackBar),
              matching: find.text('No URL found for this APOD'),
            ),
            findsOneWidget,
          );
        });
      });

      testWidgets('calls launch on the $UriLauncher with URI from Apod\'s url '
          'when $MediaType is ${MediaType.video}', (tester) async {
        _builder.withApodDetailsCubitState(state: const LoadedCubitState(null));
        final apod = TestModels.apod(mediaType: .video, url: 'fsf.org');
        await tester.pumpTested(apod: apod);

        tester
            .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
            .onApodTap!();

        verify(_builder.uriLauncher.launch(Uri.parse('fsf.org'))).called(1);
      });

      <MediaType>[.other, .image].forEach((mediaType) {
        testWidgets('pushes ${Routes.apodFullSizeScreen} '
            'and passes URL and date from Apod when $MediaType is $mediaType', (
          tester,
        ) async {
          _builder.withApodDetailsCubitState(
            state: const LoadedCubitState(null),
          );
          const url = 'fsf.org';
          final date = DateTime(1987);
          final apod = TestModels.apod(
            mediaType: mediaType,
            url: 'fsf.org',
            date: date,
          );
          await tester.pumpTested(apod: apod);

          tester
              .widget<ApodDetailsContent>(find.byType(ApodDetailsContent))
              .onApodTap!();

          verify(
            _builder.goRouter.pushNamed(
              Routes.apodFullSizeScreen,
              extra: ApodFullSizeScreenArguments(url: url, date: date),
            ),
          ).called(1);
        });
      });
    });
  });
}

extension on WidgetTester {
  Future<void> pumpTested({Apod? apod, CacheManager? cacheManager}) =>
      pumpWidget(
        Provider.value(
          value: InjectorDelegate(
            Injector([
              SingletonInjection<CacheManager>(
                (_) => cacheManager ?? _builder.cacheManager,
              ),
              SingletonInjection<UriLauncher>((_) => _builder.uriLauncher),
              AssistedFactoryInjection<ApodDetailsCubit, Apod>(
                (_, __) => _builder.apodDetailsCubit,
              ),
            ]),
          ),
          child: MaterialApp(
            home: MockGoRouterProvider(
              goRouter: _builder.goRouter,
              child: ApodDetailsScreen(apod: apod ?? TestModels.apod()),
            ),
          ),
        ),
      );
}

class _ArrangeBuilder {
  final uriLauncher = MockUriLauncher();
  final goRouter = MockGoRouter();
  final apodDetailsCubit = MockApodDetailsCubit();
  final cacheManager = MockCacheManager();

  void withApodDetailsCubitState({CubitState? state}) {
    when(
      apodDetailsCubit.state,
    ).thenAnswer((_) => state ?? const LoadingCubitState());
  }
}
