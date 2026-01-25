// ignore_for_file: cascade_invocations, unawaited_futures
import 'dart:async';

import 'package:async/async.dart';
import 'package:hello_universe/src/utils/repository/in_memory_repository.dart';
import 'package:test/test.dart';

void main() {
  late _InMemoryRepositoryImpl tested;

  setUp(() {
    tested = _InMemoryRepositoryImpl();
  });

  group('on fetch', () {
    test('returns fetched data', () async {
      final data = await tested.fetch();

      expect(data, '1');
    });

    test('second time retrieves new value', () async {
      await tested.fetch();
      tested.remoteData = '2';

      final data = await tested.fetch();

      expect(data, '2');
    });

    test('throws when repository was already disposed', () async {
      tested.dispose();

      expect(() async => tested.fetch(), throwsA(isA<AssertionError>()));
    });
  });

  group('on current', () {
    test('retrieves new value when was not fetched before', () async {
      final data = await tested.current;

      expect(data, '1');
    });

    test('returns existing value when it was fetched before', () async {
      await tested.fetch();
      tested.remoteData = '2';

      final data = await tested.current;

      expect(data, '1');
    });

    test('second time does not fetch again', () async {
      await tested.current;
      await tested.current;

      expect(tested.retrieveCount, 1);
    });

    test('multiple times fetches data once', () async {
      final repository = _DelayedInMemoryRepositoryImpl();

      repository.current;
      repository.current;
      repository.current;
      await Future<void>.value();
      repository._completer.complete('1');

      expect(repository.retrieveCount, 1);
    });

    test('throws when repository was already disposed', () async {
      tested.dispose();

      expect(() async => tested.current, throwsA(isA<AssertionError>()));
    });
  });

  group('on observe', () {
    test('fetches when did not exist before', () async {
      final stream = tested.observe();

      expect(stream, emits('1'));
    });

    test('does not fetch new values when one existed before', () async {
      await tested.fetch();
      tested.remoteData = '2';

      final stream = tested.observe();

      expect(stream, emitsInOrder(<String>['1']));
    });

    test('notifies about newly fetched values', () async {
      await tested.fetch();
      final allValues = <String>[];

      tested.observe().listen(allValues.add);
      tested.remoteData = '2';
      await tested.fetch();
      // Flush the async tasks to make sure the new value is emitted by the stream.
      await Future<void>.value();

      expect(allValues, ['1', '2']);
    });

    test('retrieves when the current value was retrieved', () async {
      await tested.current;

      tested.observe();
      // Flush the async tasks to make sure the new value is emitted by the stream.
      await Future<void>.value();

      expect(tested.retrieveCount, 1);
    });

    test('once retrieved does not refetch for the second time', () async {
      final repository = _DelayedInMemoryRepositoryImpl();
      repository.current;

      repository.observe().forEach((_) {});
      repository._completer.complete('1');

      expect(repository.retrieveCount, 1);
    });

    test('does not fetch when already fetched', () async {
      final repository = _DelayedInMemoryRepositoryImpl();
      repository.fetch();

      repository.observe().forEach((_) {});
      repository._completer.complete('1');

      expect(repository.retrieveCount, 1);
    });

    test('throws when repository was already disposed', () async {
      tested.dispose();

      expect(() async => tested.observe(), throwsA(isA<AssertionError>()));
    });
  });

  test(
    'call observe and fetch at the same time will retrieve data once',
    () async {
      final repository = _DelayedInMemoryRepositoryImpl();

      repository.observe().forEach((_) {});
      repository.fetch();
      repository._completer.complete('1');

      expect(repository.retrieveCount, 1);
    },
  );

  test('retrieves only once for several concurrent fetches', () async {
    final repository = _DelayedInMemoryRepositoryImpl();

    repository.fetch();
    repository.fetch();
    repository.fetch();
    repository._completer.complete('1');

    expect(repository.retrieveCount, 1);
  });

  test('do not publish events when repository has been disposed', () async {
    final repository = _DelayedInMemoryRepositoryImpl();
    repository.observe();
    repository.fetch();

    repository.dispose();
    repository._completer.complete('1');
  });

  group('cancelable operation on completer', () {
    test('is not cancelled when not cancelled', () async {
      final repository = _DelayedInMemoryRepositoryImpl();
      final completer = repository._completer;

      completer.complete(Future.value('42'));

      expect(completer.operation.isCompleted, isFalse);
      expect(completer.operation.isCanceled, isFalse);
    });

    test('is cancelled when cancelled', () async {
      final repository = _DelayedInMemoryRepositoryImpl();
      final completer = repository._completer;

      completer.complete(Future.value('42'));
      completer.operation.cancel();

      expect(completer.operation.isCompleted, isFalse);
      expect(completer.operation.isCanceled, isTrue);
    });
  });

  group('clear', () {
    test('fetches again when calling current', () async {
      await tested.current;

      tested.clear();
      await tested.current;

      expect(tested.retrieveCount, 2);
    });

    test('fetches again when calling observe', () async {
      await tested.current;

      tested.clear();
      tested.observe();

      expect(tested.retrieveCount, 2);
    });
  });
}

class _InMemoryRepositoryImpl extends InMemoryRepository<String> {
  String remoteData = '1';
  int retrieveCount = 0;

  @override
  Future<String> retrieve() async {
    retrieveCount++;

    return remoteData;
  }
}

class _DelayedInMemoryRepositoryImpl extends InMemoryRepository<String> {
  int retrieveCount = 0;
  final _completer = CancelableCompleter<String>();

  @override
  Future<String> retrieve() async {
    retrieveCount++;

    return _completer.operation.value;
  }
}
