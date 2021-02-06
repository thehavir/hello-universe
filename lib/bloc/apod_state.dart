part of 'apod_cubit.dart';

abstract class ApodState extends Equatable {
  const ApodState();
}

class ApodInitial extends ApodState {
  const ApodInitial();

  @override
  List<Object> get props => [];
}

class ApodLoading extends ApodState {
  const ApodLoading();

  @override
  List<Object> get props => [];
}

class ApodLoaded extends ApodState {
  final PictureOfDay pictureOfDay;

  const ApodLoaded(this.pictureOfDay);

  @override
  List<Object> get props => [pictureOfDay.url];
}
