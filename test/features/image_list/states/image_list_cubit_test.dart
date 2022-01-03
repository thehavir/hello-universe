import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/features/core/states/states.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock_data/mock_data.dart';
import '../../../repository/mock_repository.dart';

void main() {
  group('Test ImageListCubit', () {
    late BaseRepository repository;
    late ImageListCubit imageListCubit;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.now();
    final DateTime twentyDaysBefore = _subtractTwentyDays(now);
    final DateTime fortyDaysBefore = _subtractTwentyDays(twentyDaysBefore);

    setUp(() {
      repository = MockRepository();
      imageListCubit = ImageListCubit(repository);
    });

    test('Test first state is `StateStatus.initial`', () {
      expect(imageListCubit.state.status, StateStatus.initial);
    });

    blocTest(
      'Test fetch apod list successfully',
      build: () {
        when(() => repository.fetchImageList(
              startDate: formatter.format(now),
              endDate: formatter.format(twentyDaysBefore),
            )).thenAnswer((_) async => mockApodList);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetch(),
      expect: () => <ImageListState>[
        const ImageListState(status: StateStatus.loading),
        ImageListState(
            status: StateStatus.success,
            data: mockApodList,
            startDate: twentyDaysBefore),
      ],
    );

    blocTest(
      'Test fetch apod list failed',
      build: () {
        when(() => repository.fetchImageList(
              startDate: formatter.format(now),
              endDate: formatter.format(twentyDaysBefore),
            )).thenThrow(mockFetchNasaApodException);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetch(),
      expect: () => <ImageListState>[
        const ImageListState(status: StateStatus.loading),
        ImageListState(
          status: StateStatus.failure,
          error: mockFetchNasaApodException,
        ),
      ],
    );

    blocTest(
      'Test nasa apod image list with pagination',
      build: () {
        when(() => repository.fetchImageList(
              startDate: formatter.format(now),
              endDate: formatter.format(twentyDaysBefore),
            )).thenAnswer((_) async => mockApodList);

        when(() => repository.fetchImageList(
              startDate: formatter
                  .format(twentyDaysBefore.subtract(Duration(days: 1))),
              endDate:
                  formatter.format(fortyDaysBefore.subtract(Duration(days: 1))),
            )).thenAnswer((_) async => mockApodList2);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) async {
        // Mimic pagination with a delay and fetching again.
        await cubit.fetch();
        await Future<void>.delayed(const Duration(seconds: 1));
        await cubit.fetch();
      },
      expect: () => <ImageListState>[
        const ImageListState(status: StateStatus.loading),
        ImageListState(
          status: StateStatus.success,
          data: mockApodList,
          startDate: twentyDaysBefore,
        ),
        ImageListState(
          status: StateStatus.loading,
          data: mockApodList,
          startDate: twentyDaysBefore,
        ),
        ImageListState(
          status: StateStatus.success,
          data: mockApodList + mockApodList2,
          startDate: fortyDaysBefore,
        ),
      ],
    );

    // Todo(Havir): Find a way to test this:
    /*blocTest(
      'Test nasa apod image list limitation (hasMore)',
      build: () {
        final DateTime july1995 = DateTime(1995, 7, 20);

        when(() => repository.fetchImageList(
              startDate: formatter.format(july1995),
              endDate: formatter.format(_subtractTwentyDays(july1995)),
            )).thenAnswer((_) async => mockApodList);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) {
        for(int index = 0; index < 1000; index++) {
          cubit.fetch();
        }
      },
      verify: (ImageListCubit cubit) => {
        print(cubit.state.startDate),
        expect(cubit.state.hasMore, true)
      },
    );*/
  });
}

DateTime _subtractTwentyDays(DateTime startDate) =>
    startDate.subtract(Duration(days: 19));