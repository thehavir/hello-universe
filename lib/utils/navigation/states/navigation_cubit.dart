import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/models/models.dart';
import 'package:hello_universe/utils/navigation/router/router.dart';

part 'navigation_state.dart';

/// Cubit for navigation.
class NavigationCubit extends Cubit<NavigationState> {
  /// Constructs a `NavigatorCubit` and calls super with a `NavigatorState`
  /// object.
  NavigationCubit() : super(const NavigationState());

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
  Future<void> navigateToDetailsPage(Apod apod) async {
    emit(state.copyWith(
      data: PageAction(
        pageState: PageState.addPage,
        page: imageDetailsPageConfig,
        pageData: apod,
      ),
    ));
  }
}
