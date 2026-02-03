import 'package:equatable/equatable.dart';

sealed class PersistentCubitState<D extends Object?, E extends Object>
    extends Equatable {
  const PersistentCubitState._(this.data);

  final D? data;

  PersistentCubitState<D, E> toLoading({D? newData}) =>
      PersistentLoadingCubitState<D, E>(data: newData ?? data);

  PersistentCubitState<D, E> toError(E error, {D? newData}) =>
      PersistentErrorCubitState<D, E>(error, data: newData ?? data);

  PersistentCubitState<D, E> toLoaded(D data) =>
      PersistentLoadedCubitState<D, E>(data);

  @override
  List<Object?> get props => [data];
}

final class PersistentLoadingCubitState<D extends Object?, E extends Object>
    extends PersistentCubitState<D, E> {
  const PersistentLoadingCubitState({D? data}) : super._(data);
}

final class PersistentErrorCubitState<D extends Object?, E extends Object>
    extends PersistentCubitState<D, E> {
  const PersistentErrorCubitState(this.error, {D? data}) : super._(data);

  final E? error;

  @override
  List<Object?> get props => super.props + [error];
}

final class PersistentLoadedCubitState<D extends Object?, E extends Object>
    extends PersistentCubitState<D, E> {
  const PersistentLoadedCubitState(D super.data) : super._();
}
