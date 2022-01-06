import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/features/image_detail/view/image_details_page.dart';
import 'package:hello_universe/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/utils/navigation/app_navigator.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../features/core/widgets/test_wrapper.dart';
import '../../features/image_list/states/mock_state.dart';
import '../../mock_data/mock_api_model.dart';
import 'states/mock_state.dart';

void main() {
  group('Test AppNavigator widget', () {
    late NavigationCubit navigationCubit;
    late ImageListCubit imageListCubit;

    setUpAll(() {
      navigationCubit = MockNavigationCubit();
      imageListCubit = MockImageListCubit();
    });

    testWidgets('Test first page is ImageListPage',
        (WidgetTester tester) async {
      when(() => navigationCubit.state)
          .thenReturn(const NavigationStateImageListPage());

      when(() => imageListCubit.state).thenReturn(const ImageListState());

      when(() => imageListCubit.fetch()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => navigationCubit,
            ),
            BlocProvider(
              create: (_) => imageListCubit,
            ),
          ],
          child: const TestWidgetsWrapper(
            child: AppNavigator(),
          ),
        ),
      );

      await tester.pump();

      final Finder pageFinder = find.byType(ImageListPage);

      expect(pageFinder, findsOneWidget);
    });

    testWidgets('Test navigateToImageDetailsPage', (WidgetTester tester) async {
      when(() => navigationCubit.state)
          .thenReturn(NavigationStateImageDetailsPage(mockApod));

      when(() => imageListCubit.state).thenReturn(const ImageListState());

      when(() => imageListCubit.fetch()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => navigationCubit,
            ),
            BlocProvider(
              create: (_) => imageListCubit,
            ),
          ],
          child: const TestWidgetsWrapper(
            child: AppNavigator(),
          ),
        ),
      );

      await tester.pump();

      final Finder pageFinder = find.byType(ImageDetailsPage);

      expect(pageFinder, findsOneWidget);
    });
  });
}
