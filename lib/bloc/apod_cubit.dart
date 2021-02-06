import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apod_state.dart';

class ApodCubit extends Cubit<ApodState> {
  ApodCubit() : super(ApodInitial());

  Future<void> fetchApod() async {

  }
}
