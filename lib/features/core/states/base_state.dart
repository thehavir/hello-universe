import 'package:equatable/equatable.dart';

/// Contract for other cubit classes. Other states should extend from this
/// and provide the generic type as the type of data.
abstract class BaseState<T> extends Equatable {
  /// Constructs a BaseState.
  const BaseState({
    this.status = StateStatus.initial,
    this.data,
    this.error,
  });

  /// The current state.
  final StateStatus? status;

  /// The data of the state.
  final T? data;

  /// The error of the state.
  final Object? error;

  /// Returns a copy of the current state with given override parameters.
  BaseState<T> copyWith({
    StateStatus? status,
    T? data,
    Object? error,
  });

  /// Returns a copy of the current state with initial status.
  BaseState<T> initial() => copyWith(status: StateStatus.initial);

  /// Returns a copy of the current state with loading status and the current
  /// data if we had any.
  BaseState<T> loading() => copyWith(
        status: StateStatus.loading,
        data: data,
      );

  /// Returns a copy of the current state with success status and given data.
  BaseState<T> success([T? data]) => copyWith(
        status: StateStatus.success,
        data: data,
      );

  /// Returns a copy of the current state with failure status and given error
  /// and the current data if we had any.
  BaseState<T> failure([Object? error]) => copyWith(
        status: StateStatus.failure,
        data: data,
        error: error,
      );

  /// Returns true if the state contains data.
  bool get hasData => data != null;

  /// Returns true if the state contains error.
  bool get hasError => error != null;

  /// Returns true if the state [status] is equal to initial.
  bool get isInitial => status == StateStatus.initial;

  /// Returns true if the state [status] is equal to loading.
  bool get isLoading => status == StateStatus.loading;

  /// Returns true if the state [status] is equal to success.
  bool get isSuccess => status == StateStatus.success;

  /// Returns true if the state [status] is equal to failure.
  bool get isFailure => status == StateStatus.failure;

  /// Returns true if the state [status] is equal to failure and there is no
  /// data.
  bool get isFailedToInit => status == StateStatus.failure && !hasData;

  @override
  List<Object?> get props => <Object?>[status, data, error];
}

/// States status types.
enum StateStatus {
  /// Represented initial state.
  initial,

  /// Represented loading state.
  loading,

  /// Represented success state.
  success,

  /// Represented failure state.
  failure,
}