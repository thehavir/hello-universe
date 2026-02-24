// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_content.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_cubit.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_data.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_screen.dart';
import 'package:hello_universe/src/routes.dart';
import 'package:hello_universe/src/utils/dependency_injection/injection.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:hello_universe/src/utils/persistent_cubit_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../test_doubles/test_models.dart';
import '../../../test_utils/mock_go_router_provider.dart';
import 'apods_list_screen_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateNiceMocks([MockSpec<ApodsListCubit>(), MockSpec<GoRouter>()])
void main() {
  provideDummy<PersistentCubitState<ApodsListData, ApodsError>>(
    const PersistentLoadingCubitState(),
  );

  setUp(() => _builder = _ArrangeBuilder());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodsListScreen), findsOneWidget);
  });

  testWidgets('calls fetchApods on the $ApodsListCubit on screen built', (
    tester,
  ) async {
    await tester.pumpTested();

    verify(_builder.apodsListCubit.fetchApods()).called(1);
  });

  testWidgets('has $AppBar', (tester) async {
    await tester.pumpTested();

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('$AppBar has title', (tester) async {
    await tester.pumpTested();

    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Hello Universe'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('has $ApodsListContent', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodsListContent), findsOneWidget);
  });

  group('when state is $PersistentLoadedCubitState', () {
    testWidgets('passes apodPages to the $ApodsListContent', (tester) async {
      final apodPages = [
        [TestModels.apod(title: '1'), TestModels.apod(title: '2')],
        [TestModels.apod(title: '3')],
      ];
      final state = PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(
          apodPages: apodPages,
          apodPageKeys: [TestModels.apodsPageKey(), TestModels.apodsPageKey()],
        ),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPages, apodPages);
    });

    testWidgets('passes apodPageKeys to the $ApodsListContent', (tester) async {
      final apodsPageKey = [
        TestModels.apodsPageKey(isLastPage: false),
        TestModels.apodsPageKey(isLastPage: true),
      ];
      final state = PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(
          apodPages: [
            [TestModels.apod()],
            [TestModels.apod()],
          ],
          apodPageKeys: apodsPageKey,
        ),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPageKeys, apodsPageKey);
    });

    [true, false].forEach((hasNextPage) {
      testWidgets(
        'passes hasNextPage as $hasNextPage to the $ApodsListContent',
        (tester) async {
          final state = PersistentLoadedCubitState<ApodsListData, ApodsError>(
            TestModels.apodsData(hasNextPage: hasNextPage),
          );
          _builder.withApodsListCubit(state: state);

          await tester.pumpTested();

          final widget = tester.widget<ApodsListContent>(
            find.byType(ApodsListContent),
          );
          expect(widget.hasNextPage, hasNextPage);
        },
      );
    });

    testWidgets('passes isLoading as false to the $ApodsListContent', (
      tester,
    ) async {
      final state = PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.isLoading, isFalse);
    });

    testWidgets('passes error as null to the $ApodsListContent', (
      tester,
    ) async {
      final state = PersistentLoadedCubitState<ApodsListData, ApodsError>(
        TestModels.apodsData(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.error, isNull);
    });
  });

  group('when state is $PersistentLoadingCubitState', () {
    testWidgets('passes apodPages to the $ApodsListContent', (tester) async {
      final apodPages = [
        [TestModels.apod(title: '1'), TestModels.apod(title: '2')],
        [TestModels.apod(title: '3')],
      ];
      final state = PersistentLoadingCubitState<ApodsListData, ApodsError>(
        data: TestModels.apodsData(
          apodPages: apodPages,
          apodPageKeys: [TestModels.apodsPageKey(), TestModels.apodsPageKey()],
        ),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPages, apodPages);
    });

    testWidgets('passes null as apodsPages to the $ApodsListContent', (
      tester,
    ) async {
      const state = PersistentLoadingCubitState<ApodsListData, ApodsError>();
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPages, isNull);
    });

    testWidgets('passes null as apodsPageKeys to the $ApodsListContent', (
      tester,
    ) async {
      const state = PersistentLoadingCubitState<ApodsListData, ApodsError>();
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPageKeys, isNull);
    });

    testWidgets('passes apodPageKeys to the $ApodsListContent', (tester) async {
      final apodsPageKey = [
        TestModels.apodsPageKey(isLastPage: false),
        TestModels.apodsPageKey(isLastPage: true),
      ];
      final state = PersistentLoadingCubitState<ApodsListData, ApodsError>(
        data: TestModels.apodsData(
          apodPages: [
            [TestModels.apod()],
            [TestModels.apod()],
          ],
          apodPageKeys: apodsPageKey,
        ),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPageKeys, apodsPageKey);
    });

    [true, false].forEach((hasNextPage) {
      testWidgets('passes hasNextPage as $hasNextPage to the $ApodsListContent '
          'when data is not null', (tester) async {
        final state = PersistentLoadingCubitState<ApodsListData, ApodsError>(
          data: TestModels.apodsData(hasNextPage: hasNextPage),
        );
        _builder.withApodsListCubit(state: state);

        await tester.pumpTested();

        final widget = tester.widget<ApodsListContent>(
          find.byType(ApodsListContent),
        );
        expect(widget.hasNextPage, hasNextPage);
      });
    });

    testWidgets('passes hasNextPage as true to the $ApodsListContent '
        'when data is null', (tester) async {
      const state = PersistentLoadingCubitState<ApodsListData, ApodsError>();
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.hasNextPage, true);
    });

    testWidgets('passes isLoading as true to the $ApodsListContent', (
      tester,
    ) async {
      const state = PersistentLoadingCubitState<ApodsListData, ApodsError>();
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.isLoading, isTrue);
    });

    testWidgets('passes error as null to the $ApodsListContent', (
      tester,
    ) async {
      const state = PersistentLoadingCubitState<ApodsListData, ApodsError>();
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.error, isNull);
    });
  });

  group('when state is $PersistentErrorCubitState', () {
    testWidgets('passes apodPages to the $ApodsListContent', (tester) async {
      final apodPages = [
        [TestModels.apod(title: '1'), TestModels.apod(title: '2')],
        [TestModels.apod(title: '3')],
      ];
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        data: TestModels.apodsData(
          apodPages: apodPages,
          apodPageKeys: [TestModels.apodsPageKey(), TestModels.apodsPageKey()],
        ),
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPages, apodPages);
    });

    testWidgets('passes null as apodsPages to the $ApodsListContent '
        'when data is null', (tester) async {
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPages, isNull);
    });

    testWidgets('passes apodPageKeys to the $ApodsListContent', (tester) async {
      final apodsPageKey = [
        TestModels.apodsPageKey(isLastPage: false),
        TestModels.apodsPageKey(isLastPage: true),
      ];
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        data: TestModels.apodsData(
          apodPages: [
            [TestModels.apod()],
            [TestModels.apod()],
          ],
          apodPageKeys: apodsPageKey,
        ),
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPageKeys, apodsPageKey);
    });

    testWidgets('passes null as apodsPageKeys to the $ApodsListContent '
        'when data is null', (tester) async {
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.apodPageKeys, isNull);
    });

    [true, false].forEach((hasNextPage) {
      testWidgets('passes hasNextPage as $hasNextPage to the $ApodsListContent '
          'when data is not null', (tester) async {
        final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
          data: TestModels.apodsData(hasNextPage: hasNextPage),
          TestModels.apodsError(),
        );
        _builder.withApodsListCubit(state: state);

        await tester.pumpTested();

        final widget = tester.widget<ApodsListContent>(
          find.byType(ApodsListContent),
        );
        expect(widget.hasNextPage, hasNextPage);
      });
    });

    testWidgets('passes hasNextPage as true to the $ApodsListContent '
        'when data is null', (tester) async {
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.hasNextPage, true);
    });

    testWidgets('passes isLoading as false to the $ApodsListContent', (
      tester,
    ) async {
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        TestModels.apodsError(),
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.isLoading, isFalse);
    });

    testWidgets('passes error from $ApodsError to the $ApodsListContent', (
      tester,
    ) async {
      final apodsError = TestModels.apodsError(error: 'Explosion');
      final state = PersistentErrorCubitState<ApodsListData, ApodsError>(
        apodsError,
      );
      _builder.withApodsListCubit(state: state);

      await tester.pumpTested();

      final widget = tester.widget<ApodsListContent>(
        find.byType(ApodsListContent),
      );
      expect(widget.error, apodsError.error);
    });
  });

  testWidgets('onFetchNextPage calls fetchApods on the $ApodsListCubit', (
    tester,
  ) async {
    await tester.pumpTested();

    tester
        .widget<ApodsListContent>(find.byType(ApodsListContent))
        .onFetchNextPage();

    // First call is the initial call that happens on the screen build
    verify(_builder.apodsListCubit.fetchApods()).called(2);
  });

  testWidgets('onRetry calls refresh on the $ApodsListCubit', (tester) async {
    await tester.pumpTested();

    tester.widget<ApodsListContent>(find.byType(ApodsListContent)).onRetry();

    verify(_builder.apodsListCubit.refresh()).called(1);
  });

  testWidgets('onApodTap pushes ${Routes.apodDetailsScreen} with the $Apod', (
    tester,
  ) async {
    final apod = TestModels.apod(title: 'Gemeni');
    await tester.pumpTested();

    tester
        .widget<ApodsListContent>(find.byType(ApodsListContent))
        .onApodTap(apod);

    verify(
      _builder.goRouter.pushNamed(Routes.apodDetailsScreen, extra: apod),
    ).called(1);
  });
}

extension on WidgetTester {
  Future<void> pumpTested() => pumpWidget(
    Provider.value(
      value: InjectorDelegate(
        Injector([
          FactoryInjection<ApodsListCubit>((_) => _builder.apodsListCubit),
        ]),
      ),
      child: MaterialApp(
        home: MockGoRouterProvider(
          goRouter: _builder.goRouter,
          child: const ApodsListScreen(),
        ),
      ),
    ),
  );
}

class _ArrangeBuilder {
  final apodsListCubit = MockApodsListCubit();
  final goRouter = MockGoRouter();

  void withApodsListCubit({
    PersistentCubitState<ApodsListData, ApodsError>? state,
  }) {
    when(
      apodsListCubit.state,
    ).thenAnswer((_) => state ?? const PersistentLoadingCubitState());
  }
}
