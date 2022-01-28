import 'package:bloc/bloc.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/features/image_list/extensions/extension.dart';
import 'package:hello_universe/models/apod.dart';
import 'package:hello_universe/repository/repository.dart';

part 'image_list_state.dart';

/// Cubit for Image list.
class ImageListCubit extends Cubit<ImageListState> {
  /// Constructs an `ImageListCubit`.other
  ImageListCubit(this.repository) : super(const ImageListState());

  /// Nasa APOD repository.
  final BaseRepository repository;

  /// Fetch a list of Nasa APOD in a specified period (`startDate` till
  /// `endDate`).
  Future<void> fetch() async {
    try {
      if (state.hasMore && !state.isLoading) {
        emit(state.copyWith(status: StateStatus.loading));

        final List<PictureOfDay> imageList = await repository.fetchImageList(
          startDate: _startDate.format(),
          endDate: _endDate.format(),
        );

        emit(state.copyWith(
          status: StateStatus.success,
          data: state.data != null ? state.data! + imageList : imageList,
          // Subtract one day in order to prevent duplication of last item.
          startDate: _endDate.xDaysBefore(1),
          hasMore: _endDate.difference(firstImageDate).inDays > 0,
        ));
      }
    } on Exception catch (error) {
      emit(state.copyWith(status: StateStatus.failure, error: error));
    }
  }

  DateTime get _startDate {
    if (state.startDate == null) {
      return DateTime.now();
    }

    return state.startDate!;
  }

  DateTime get _endDate {
    final DateTime potentialEndDate = _startDate.xDaysBefore();

    if (potentialEndDate.difference(firstImageDate).inDays <= 0) {
      return firstImageDate;
    }

    return potentialEndDate;
  }
}
