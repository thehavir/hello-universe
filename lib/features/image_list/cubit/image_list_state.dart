part of 'image_list_cubit.dart';

abstract class ImageListState extends Equatable {
  const ImageListState();

  @override
  List<Object> get props => [];
}

class ImageListStateInitial extends ImageListState {
  const ImageListStateInitial();
}

class ImageListStateLoading extends ImageListState {
  const ImageListStateLoading();
}

class ImageListStateLoaded extends ImageListState {
  final List<PictureOfDay> imageList;

  const ImageListStateLoaded(this.imageList);

  @override
  List<Object> get props => [imageList];
}

class ImageListStateFailed extends ImageListState {
  final String error;

  const ImageListStateFailed(this.error);

  @override
  List<Object> get props => [error];
}
