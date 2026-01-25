import 'dart:async';

import 'package:async/async.dart';
import 'package:hello_universe/src/utils/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

/// Repository that stores data in memory.
abstract class InMemoryRepository<S> implements Repository<S>, Retriever<S> {
  BehaviorSubject<S>? _cachedSubject;
  bool _disposed = false;
  bool _invalidated = false;
  CancelableCompleter<S>? _retrieveCompleter;

  Future<void> _init() async {
    if (_cachedSubject?.valueOrNull == null) {
      await fetch();
    }
  }

  @override
  Future<S> fetch() async {
    assert(!_disposed);

    var completer = _retrieveCompleter;
    if (completer != null) {
      // A fetch is already in progress and it returns the same Future<S> from
      // the ongoing operation. Prevents duplicate network calls.
      return completer.operation.value;
    }

    completer = CancelableCompleter<S>();
    _retrieveCompleter = completer;

    completer.complete(retrieve());

    try {
      final value = await completer.operation.value;
      if (!_disposed) {
        _lazySubject().add(value);
      }

      return value;
    } finally {
      _retrieveCompleter = null;
    }
  }

  @override
  Future<S> get current async {
    if (_invalidated) {
      _invalidated = false;
      return fetch();
    } else {
      return observe().first;
    }
  }

  @override
  Stream<S> observe() {
    assert(!_disposed);

    if (_invalidated) {
      _invalidated = false;
      // Triggers a fetch in the background.
      fetch();
    }

    return _lazySubject(fetchOnListen: true).stream;
  }

  // Return the cached subject if it exists, or create a new one.
  BehaviorSubject<S> _lazySubject({bool fetchOnListen = false}) =>
      _cachedSubject ??= BehaviorSubject<S>(
        onListen: fetchOnListen ? _init : null,
      );

  @override
  void clear() => _invalidated = true;

  @override
  void dispose() {
    _disposed = true;
    _cachedSubject?.close();
    _retrieveCompleter?.operation.cancel();
  }
}
