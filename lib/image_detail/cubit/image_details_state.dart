part of 'image_details_cubit.dart';

abstract class ImageDetailsState extends Equatable {
  const ImageDetailsState();

  @override
  List<Object> get props => [];
}

class ImageDetailsInitialState extends ImageDetailsState {
  const ImageDetailsInitialState();
}

class ImageDetailsLoadingState extends ImageDetailsState {
  const ImageDetailsLoadingState();
}

class ImageDetailsLoadedState extends ImageDetailsState {
  final PictureOfDay pictureOfDay;

  const ImageDetailsLoadedState(this.pictureOfDay);

  @override
  List<Object> get props => [pictureOfDay];
}

class ImageDetailsFetchFailedState extends ImageDetailsState {
  final String error;

  const ImageDetailsFetchFailedState(this.error);
}
