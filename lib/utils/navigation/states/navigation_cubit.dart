import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello_universe/models/apod.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationStateInitial());

  Future<void> navigateToImageDetailsPage(PictureOfDay pictureOfDay) async =>
      emit(NavigationStateImageDetailsPage(pictureOfDay));

  Future<void> navigateToImageListPage() async =>
      emit(const NavigationStateImageListPage());
}
