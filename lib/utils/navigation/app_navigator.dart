import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/image_detail/view/image_details_page.dart';
import 'package:hello_universe/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NavigationCubit, NavigationState>(
        builder: (BuildContext context, NavigationState state) => Navigator(
          key: key,
          pages: [
            const MaterialPage<bool>(child: ImageListPage()),
            if (state is NavigationStateImageDetailsPage)
              MaterialPage(
                child: ImageDetailsPage(
                  apod: state.pictureOfDay,
                ),
              ),
          ],
          onPopPage: (Route<dynamic> route, dynamic result) {
            context.read<NavigationCubit>().navigateToImageListPage();

            return route.didPop(result);
          },
        ),
      );
}
