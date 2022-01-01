import 'package:bloc/bloc.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/models/apod.dart';
import 'package:hello_universe/repository/repository.dart';
import 'package:intl/intl.dart';

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
          startDate: _formatter.format(_startDate),
          endDate: _formatter.format(_endDate),
        );

        // Todo(Havir): Check the first APOD and set `hasMore`.
        emit(state.copyWith(
          status: StateStatus.success,
          data: state.data != null ? state.data! + imageList : imageList,
          // Subtract one day in order to prevent duplication of last item.
          startDate: _endDate.subtract(Duration(days: 1)),
          // hasMore: _endDate.difference().inDays == 0,
        ));
      }
    } on Exception catch (error) {
      print(error);

      emit(state.copyWith(status: StateStatus.failure, error: error));
    }
  }

  // Todo(Havir): Add extension for this part (e.g. _startDate.format()).
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  DateTime get _startDate {
    if (state.startDate == null) {
      return DateTime.now();
    }

    return state.startDate!;
  }

  DateTime get _endDate => _startDate.subtract(Duration(days: 19));
}
