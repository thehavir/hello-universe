import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/utils/navigation/router/router.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

import '../../../mock_data/mock_api_model.dart';

void main() {
  group('Test `NavigationCubit`', () {
    late NavigationCubit navigationCubit;

    setUpAll(() {
      navigationCubit = NavigationCubit();
    });

    test('Test first state is `StateStatus.initial`', () {
      expect(navigationCubit.state.status, StateStatus.initial);
    });

    blocTest(
      'Test navigateToImageList method',
      build: () => navigationCubit,
      act: (NavigationCubit cubit) => cubit.navigateToImageListPage(),
      verify: (NavigationCubit cubit) {
        expect(cubit.state.pageState, PageState.replaceAll);
        expect(cubit.state.page, imageListPageConfig);
      },
    );

    blocTest(
      'Test `navigateToImageDetailsPage` method',
      // Todo(Havir): If we use `navigationCubit`, we get an error. Investigate
      // What is the issue and see why cubit will be closed.
      build: () => NavigationCubit(),
      act: (NavigationCubit cubit) => cubit.navigateToDetailsPage(mockApod),
      verify: (NavigationCubit cubit) {
        expect(cubit.state.pageState, PageState.addPage);
        expect(cubit.state.page, imageDetailsPageConfig);
        expect(cubit.state.pageData, mockApod);
      },
    );

    blocTest(
      'Test `resetCurrentAction` method',
      // Todo(Havir): If we use `navigationCubit`, we get an error. Investigate
      // What is the issue and see why cubit will be closed.
      build: () => NavigationCubit(),
      act: (NavigationCubit cubit) => cubit.resetCurrentAction(),
      verify: (NavigationCubit cubit) {
        expect(cubit.state.pageState, PageState.none);
        expect(cubit.state.page, null);
      },
    );
  });
}
