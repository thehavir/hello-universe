import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

part 'image_list_state.dart';

/// Bloc (Cubit) that handles fetching list of images from Nasa repository.
class ImageListCubit extends Cubit<ImageListState> {
  /// Constructor of `ImageListCubit` class.
  ImageListCubit(this.nasaApodRepository)
      : super(const ImageListStateInitial());

  /// It's our repository that is an interface for communicating with server
  /// (Like fetching image, and etc).
  final NasaApodRepository nasaApodRepository;

  /// Method for fetching list of `PictureOfDay` images.
  ///
  /// It gets two parameter, [startDate] and [endDate], and will return a list
  /// of `PictureOfDay` images between these dates.
  Future<void> fetchImageList({
    @required String startDate,
    @required String endDate,
  }) async {
    emit(const ImageListStateLoading());

    try {
      final List<PictureOfDay> imageList = await nasaApodRepository
          .fetchImageList(startDate: startDate, endDate: endDate);

      emit(ImageListStateLoaded(imageList));
    } catch (error) {
      print(error);
      emit(ImageListStateFailed(error.toString()));
    }
  }
}
