import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/models/apod.dart';
import 'package:hello_universe/utils/navigation/router/router.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState());

  /// Resets the page state to none.
  Future<void> resetCurrentAction() async {
    emit(state.copyWith(data: PageAction()));
  }

  /// Navigates to `ImageListPage`.
  Future<void> navigateToImageListPage() async {
    emit(state.copyWith(
      data: PageAction(
        pageState: PageState.replaceAll,
        page: imageListPageConfig,
      ),
    ));
  }

  /// Navigates to `ImageDetailsPage`.
  Future<void> navigateToDetailsPage(PictureOfDay pictureOfDay) async {
    emit(state.copyWith(
      data: PageAction(
        pageState: PageState.addPage,
        page: imageDetailsPageConfig,
        pageData: pictureOfDay,
      ),
    ));
  }
}
