part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  List<Object> get props => <Object>[];
}

class NavigationStateInitial extends NavigationState {
  const NavigationStateInitial();
}

class NavigationStateImageDetailsPage extends NavigationState {
  const NavigationStateImageDetailsPage(this.pictureOfDay);

  final PictureOfDay pictureOfDay;

  @override
  List<Object> get props => <Object>[pictureOfDay];
}

class NavigationStateImageListPage extends NavigationState {
  const NavigationStateImageListPage();
}
