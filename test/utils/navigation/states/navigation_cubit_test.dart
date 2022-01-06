import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

import '../../../mock_data/mock_api_model.dart';

void main() {
  late NavigationCubit navigationCubit;

  group('Test NavigationCubit', () {
    setUp(() {
      EquatableConfig.stringify = true;
      navigationCubit = NavigationCubit();
    });

    test('Test first state is initial state', () {
      expect(navigationCubit.state, const NavigationStateInitial());
    });

    blocTest(
      'Test navigateToImageDetailsPage',
      build: () => navigationCubit,
      act: (NavigationCubit cubit) =>
          cubit.navigateToImageDetailsPage(mockApod),
      expect: () => <NavigationState>[
        NavigationStateImageDetailsPage(mockApod),
      ],
    );

    blocTest(
      'Test navigateToImageListPage',
      build: () => navigationCubit,
      act: (NavigationCubit cubit) => cubit.navigateToImageListPage(),
      expect: () => <NavigationState>[
        NavigationStateImageListPage(),
      ],
    );

    tearDownAll(() {
      navigationCubit.close();
    });
  });
}
