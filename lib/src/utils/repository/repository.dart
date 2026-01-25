import 'dart:async';

import 'package:hello_universe/src/utils/disposable.dart';
import 'package:meta/meta.dart' show protected, mustCallSuper;

abstract interface class Repository<S> implements Disposable {
  /// Returns cached value.
  Future<S> get current;

  /// Retrieves a new value.
  Future<S> fetch();

  /// Observes the values of the repository.
  Stream<S> observe();

  /// Invalidates repository cache.
  /// After calling this, the next time [observe] or [current] is called then
  /// new data will be fetched.
  void clear();
}

/// Interface for retrieval of the new values.
abstract class Retriever<S> {
  @protected
  @mustCallSuper
  Future<S> retrieve();
}
