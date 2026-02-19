import 'package:clock/clock.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/apods_pagination_handler.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test_doubles/test_models.dart';
import 'apods_pagination_handler_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateMocks([Clock])
void main() {
  final firstImageDate = DateTime(1995, 6, 16);

  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<ApodsPaginationHandlerImpl>());
  });
  group('on nextPageKey', () {
    group('when current pageKey is null', () {
      test('returns $ApodsPageKey with endDate as yesterday '
          'when yesterday is after the first APOD date', () {
        final now = DateTime(2020, 10, 25);
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            DateTime(2020, 10, 24),
          ),
        );
      });

      test('returns $ApodsPageKey with endDate as first APOD date '
          'when yesterday is equal to the first APOD date', () {
        final now = firstImageDate.add(const Duration(days: 1));
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with endDate as first APOD date '
          'when yesterday is before the first APOD date', () {
        final now = firstImageDate.subtract(const Duration(days: 10));
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when yesterday is equal to the first APOD date', () {
        final now = firstImageDate.add(const Duration(days: 1));
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when yesterday is before the first APOD date', () {
        final now = firstImageDate.subtract(const Duration(days: 10));
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test(
        'returns $ApodsPageKey with startDate as twenty days before yesterday '
        'when twenty days before yesterday is after the first APOD date',
        () {
          final now = DateTime(2020, 10, 25);
          when(_builder.clock.now()).thenReturn(now);
          final tested = _builder.createTested();

          final pageKey = tested.nextPageKey(null);

          expect(
            pageKey,
            isA<ApodsPageKey>().having(
              (p) => p.startDate,
              'startDate',
              DateTime(2020, 10, 04),
            ),
          );
        },
      );

      test(
        'returns $ApodsPageKey with startDate as first APOD date '
        'when twenty days before yesterday is equal to the first APOD date',
        () {
          final now = firstImageDate.add(const Duration(days: 21));
          when(_builder.clock.now()).thenReturn(now);
          final tested = _builder.createTested();

          final pageKey = tested.nextPageKey(null);

          expect(
            pageKey,
            isA<ApodsPageKey>().having(
              (p) => p.startDate,
              'startDate',
              firstImageDate,
            ),
          );
        },
      );

      test(
        'returns $ApodsPageKey with startDate as first APOD date '
        'when twenty days before yesterday is before the first APOD date',
        () {
          final now = firstImageDate.add(const Duration(days: 10));
          when(_builder.clock.now()).thenReturn(now);
          final tested = _builder.createTested();

          final pageKey = tested.nextPageKey(null);

          expect(
            pageKey,
            isA<ApodsPageKey>().having(
              (p) => p.startDate,
              'startDate',
              firstImageDate,
            ),
          );
        },
      );

      test(
        'returns $ApodsPageKey with isLastPage as true '
        'when twenty days before yesterday is equal to the first APOD date',
        () {
          final now = firstImageDate.add(const Duration(days: 21));
          when(_builder.clock.now()).thenReturn(now);
          final tested = _builder.createTested();

          final pageKey = tested.nextPageKey(null);

          expect(
            pageKey,
            isA<ApodsPageKey>().having(
              (p) => p.isLastPage,
              'isLastPage',
              isTrue,
            ),
          );
        },
      );

      test(
        'returns $ApodsPageKey with isLastPage as true '
        'when twenty days before yesterday is before the first APOD date',
        () {
          final now = firstImageDate.add(const Duration(days: 10));
          when(_builder.clock.now()).thenReturn(now);
          final tested = _builder.createTested();

          final pageKey = tested.nextPageKey(null);

          expect(
            pageKey,
            isA<ApodsPageKey>().having(
              (p) => p.isLastPage,
              'isLastPage',
              isTrue,
            ),
          );
        },
      );

      test('returns $ApodsPageKey with isLastPage as false '
          'when twenty days before yesterday is after the first APOD date', () {
        final now = DateTime(2020, 10, 25);
        when(_builder.clock.now()).thenReturn(now);
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(null);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.isLastPage,
            'isLastPage',
            isFalse,
          ),
        );
      });
    });

    group('when current pageKey is not null', () {
      test('returns $ApodsPageKey '
          'with endDate as one day before start date of previous page key '
          'when that is after the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: DateTime(2020, 10, 25),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            DateTime(2020, 10, 24),
          ),
        );
      });

      test('returns $ApodsPageKey with endDate as first APOD date '
          'when one day before start date of previous page key '
          'is equal to the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 1)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with endDate as first APOD date '
          'when one day before start date of previous page key '
          'is before the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.subtract(const Duration(days: 10)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.endDate,
            'endDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when one day before start date of previous page key '
          'is equal to the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 1)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when one day before start date of previous page key '
          'is before the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.subtract(const Duration(days: 10)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test('returns $ApodsPageKey '
          'with startDate as twenty one days before start date of previous page key '
          'when that is after the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: DateTime(2020, 10, 25),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.startDate,
            'startDate',
            DateTime(2020, 10, 04),
          ),
        );
      });

      test('returns $ApodsPageKey with startDate as first APOD date '
          'when twenty one days before start date of previous page key '
          'is equal to the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 21)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.startDate,
            'startDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with startDate as first APOD date '
          'when twenty one days before start date of previous page key '
          'is before the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 10)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.startDate,
            'startDate',
            firstImageDate,
          ),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when twenty one days before start date of previous page key '
          'is equal to the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 21)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test('returns $ApodsPageKey with isLastPage as true '
          'when twenty one days before start date of previous page key '
          'is before the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: firstImageDate.add(const Duration(days: 10)),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having((p) => p.isLastPage, 'isLastPage', isTrue),
        );
      });

      test('returns $ApodsPageKey with isLastPage as false '
          'when twenty one days before start date of previous page key '
          'is after the first APOD date', () {
        final currentPageKey = TestModels.apodsPageKey(
          startDate: DateTime(2020, 10, 25),
        );
        final tested = _builder.createTested();

        final pageKey = tested.nextPageKey(currentPageKey);

        expect(
          pageKey,
          isA<ApodsPageKey>().having(
            (p) => p.isLastPage,
            'isLastPage',
            isFalse,
          ),
        );
      });
    });
  });
}

class _ArrangeBuilder {
  final clock = MockClock();

  ApodsPaginationHandler createTested({Clock? clock}) =>
      ApodsPaginationHandlerImpl(clock: clock ?? this.clock);
}
