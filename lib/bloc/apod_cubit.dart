import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello_universe/repository/NasaApodRepository.dart';

part 'apod_state.dart';

class ApodCubit extends Cubit<ApodState> {
  final NasaApodRepository nasaApodRepository;

  ApodCubit(this.nasaApodRepository) : super(ApodInitial());

  Future<void> fetchApod() async {

  }
}
