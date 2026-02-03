import 'package:equatable/equatable.dart';

sealed class CubitState<D, E extends Object> extends Equatable {
  const CubitState._();

  CubitState<D, E> toLoading() => LoadingCubitState<D, E>();

  CubitState<D, E> toError(E error) => ErrorCubitState<D, E>(error);

  CubitState<D, E> toLoaded(D data) => LoadedCubitState<D, E>(data);
}

final class LoadingCubitState<D, E extends Object> extends CubitState<D, E> {
  const LoadingCubitState() : super._();

  @override
  List<Object?> get props => [];
}

final class LoadedCubitState<D, E extends Object> extends CubitState<D, E> {
  const LoadedCubitState(this.data) : super._();

  final D data;

  @override
  List<Object?> get props => [data];
}

final class ErrorCubitState<D, E extends Object> extends CubitState<D, E> {
  const ErrorCubitState(this.error) : super._();

  final E error;

  @override
  List<Object?> get props => [error];
}
