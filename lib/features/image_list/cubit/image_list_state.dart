part of 'image_list_cubit.dart';

/// Abstract class that is the parent class of image list states.
abstract class ImageListState extends Equatable {
  /// Constructor of `ImageListState` class.
  const ImageListState();

  @override
  List<Object> get props => [];
}

/// Initial state for `ImageListState`.
class ImageListStateInitial extends ImageListState {
  const ImageListStateInitial();
}

/// Loading state for `ImageListState`. It's called when `ImageListCubit` is
/// fetching data from the server.
class ImageListStateLoading extends ImageListState {
  /// Constructor of `ImageListStateLoading` class.
  const ImageListStateLoading();
}

/// When data (image list) is fetched successfully, then this state will be
/// called. It contains list of the images.
class ImageListStateLoaded extends ImageListState {
  /// Constructor of `ImageListStateLoaded` class.
  const ImageListStateLoaded(this.imageList);

  /// List of the images that are fetched from the server.
  final List<PictureOfDay> imageList;

  @override
  List<Object> get props => [imageList];
}

/// When fetching image list is failed, then this state will be called.
class ImageListStateFailed extends ImageListState {
  /// Constructor of `ImageListStateFailed` class.
  const ImageListStateFailed(this.error);

  /// Message of the error that we get.
  final String error;

  @override
  List<Object> get props => [error];
}
