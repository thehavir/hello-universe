part of 'apod_cubit.dart';

abstract class ApodState extends Equatable {
  const ApodState();
}

class ApodInitial extends ApodState {
  const ApodInitial();

  @override
  List<Object> get props => [];
}
