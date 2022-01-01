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
            startDate: '2016-01-25',
            endDate: '2016-02-25')).thenAnswer((_) async => mockApodList);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetch(),
      expect: () => <ImageListState>[
        const ImageListState(status: StateStatus.loading),
        ImageListState(status: StateStatus.success, data: mockApodList),
      ],
    );

    blocTest(
      'Test fetch apod list failed',
      build: () {
        when(() => repository.fetchImageList(
            startDate: '2016-01-25',
            endDate: '2016-02-25')).thenThrow(mockFetchNasaApodException);

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

    final DateFormat _formatter = DateFormat('yyyy-MM-dd');
    final DateTime startDate1 = DateTime.now();
    final DateTime startDate2 = _endDate(startDate1);
    final DateTime startDate3 = _endDate(startDate2);

    blocTest(
      'Test nasa apod image list with pagination',
      build: () {
        when(() => repository.fetchImageList(
              startDate: _formatter.format(startDate1),
              endDate: _formatter.format(startDate2),
            )).thenAnswer((_) async => mockApodList);

        when(() => repository.fetchImageList(
              startDate: _formatter.format(startDate2),
              endDate: _formatter.format(startDate3),
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
          startDate: startDate2,
        ),
        ImageListState(
          status: StateStatus.loading,
          data: mockApodList,
          startDate: startDate2,
        ),
        ImageListState(
          status: StateStatus.success,
          data: mockApodList2,
          startDate: startDate3,
        ),
      ],
    );
  });
}

DateTime _endDate(DateTime startDate) => startDate.subtract(Duration(days: 20));
