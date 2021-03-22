part of 'image_details_cubit.dart';

/// State class for [ImageDetailsCubit] cubit.
abstract class ImageDetailsState extends Equatable {
  const ImageDetailsState();

  @override
  List<Object> get props => [];
}

/// Initial state for [ImageDetailsState].
class ImageDetailsInitialState extends ImageDetailsState {
  const ImageDetailsInitialState();
}

/// State that indicates [ImageDetailsCubit] is fetching the APOD.
class ImageDetailsLoadingState extends ImageDetailsState {
  const ImageDetailsLoadingState();
}

/// State that indicates image (APOD) is fetched from Nasa API.
class ImageDetailsLoadedState extends ImageDetailsState {
  /// Image that is fetched from the API response.
  final PictureOfDay pictureOfDay;

  const ImageDetailsLoadedState(this.pictureOfDay);

  @override
  List<Object> get props => [pictureOfDay];
}

/// State that indicates an error is occurred while fetching image (APOD).
class ImageDetailsFetchFailedState extends ImageDetailsState {
  /// The error message that is occurred while fetching image.
  final String error;

  const ImageDetailsFetchFailedState(this.error);
}
