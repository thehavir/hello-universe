import 'package:equatable/equatable.dart';

typedef OnStateLoading<R> = R Function();
typedef OnStateError<R, E extends Object> = R Function(E error);
typedef OnStateLoaded<R, D> = R Function(D data);

/// Base state for cubits.
abstract class CubitState<D, E extends Object> extends Equatable {
  const CubitState._();

  static CubitState<D, E> loading<D, E extends Object>() =>
      LoadingCubitState<D, E>();

  static CubitState<D, E> error<D, E extends Object>(E error) =>
      ErrorCubitState<D, E>(error);

  static CubitState<D, E> loaded<D, E extends Object>(D data) =>
      LoadedCubitState<D, E>(data);

  CubitState<D, E> toLoading() => LoadingCubitState<D, E>();

  CubitState<D, E> toError(E error) => ErrorCubitState<D, E>(error);

  CubitState<D, E> toLoaded(D data) => LoadedCubitState<D, E>(data);

  /// Provides a null-safe access to the different states and the
  /// associated [data] or [error], for example to build Widgets. Example:
  ///
  /// ```
  /// return state.match(
  ///   onLoading: () => CircularProgressIndicator(),
  ///   onError: (error) => ErrorContent(error),
  ///   onLoaded: (data) => SuccessContent(data),
  /// );
  /// ```
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  });
}

class LoadingCubitState<D, E extends Object> extends CubitState<D, E> {
  const LoadingCubitState() : super._();

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) => onLoading();

  @override
  List<Object?> get props => [];
}

class ErrorCubitState<D, E extends Object> extends CubitState<D, E> {
  const ErrorCubitState(this.error) : super._();

  final E error;

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) => onError(error);

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

class LoadedCubitState<D, E extends Object> extends CubitState<D, E> {
  const LoadedCubitState(this.data) : super._();

  final D data;

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) => onLoaded(data);

  @override
  List<Object?> get props => [data];
}
