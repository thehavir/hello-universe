import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';

part 'image_details_state.dart';

/// Bloc (Cubit) that handles fetching image from Nasa repository.
class ImageDetailsCubit extends Cubit<ImageDetailsState> {
  final NasaApodRepository nasaApodRepository;

  ImageDetailsCubit(this.nasaApodRepository)
      : super(const ImageDetailsInitialState());

  Future<void> fetchImageDetails() async {
    emit(const ImageDetailsLoadingState());

    try {
      final PictureOfDay pictureOfDay =
          await nasaApodRepository.fetchPictureOfDay();

      emit(ImageDetailsLoadedState(pictureOfDay));
    } catch (error) {
      print(error);
      emit(ImageDetailsFetchFailedState(error.toString()));
    }
  }
}
