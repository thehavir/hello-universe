import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/features/image_detail/cubit/image_details_cubit.dart';
import 'package:hello_universe/repository/fake_nasa_apod_repository.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';
import 'package:mockito/mockito.dart';

class MockNasaApodRepository extends Mock implements NasaApodRepository {}

void main() {
  NasaApodRepository mockNasaApodRepository;

  group('Test image details Cubit', () {
    ImageDetailsCubit imageDetailsCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      mockNasaApodRepository = MockNasaApodRepository();
      imageDetailsCubit = ImageDetailsCubit(mockNasaApodRepository);
    });

    test('First state is [ImageDetailsInitialState]', () {
      expect(imageDetailsCubit.state, const ImageDetailsInitialState());
    });

    blocTest<ImageDetailsCubit, ImageDetailsState>(
      'Test fetch nasa apod',
      build: () {
        when(mockNasaApodRepository.fetchPictureOfDay())
            .thenAnswer((_) async => mockApod);

        return imageDetailsCubit;
      },
      act: (cubit) => cubit.fetchImageDetails(),
      expect: [
        const ImageDetailsLoadingState(),
        ImageDetailsLoadedState(mockApod),
      ],
    );

    blocTest<ImageDetailsCubit, ImageDetailsState>(
      'Test fetched apod is correct',
      build: () {
        when(mockNasaApodRepository.fetchPictureOfDay())
            .thenAnswer((_) async => mockApod);

        return imageDetailsCubit;
      },
      act: (cubit) => cubit.fetchImageDetails(),
      expect: [
        const ImageDetailsLoadingState(),
        ImageDetailsLoadedState(mockApod),
      ],
      verify: (cubit) {
        final ImageDetailsLoadedState state =
            cubit.state as ImageDetailsLoadedState;

        expect(state.pictureOfDay.url, mockApod.url);
      },
    );

    blocTest<ImageDetailsCubit, ImageDetailsState>(
      'Test fetch failed',
      build: () {
        when(mockNasaApodRepository.fetchPictureOfDay())
            .thenThrow((_) async => Exception('Fake exception!'));

        return imageDetailsCubit;
      },
      act: (cubit) => cubit.fetchImageDetails(),
      expect: [
        const ImageDetailsLoadingState(),
        ImageDetailsFetchFailedState(mockNasaApodApiErrorMessage),
      ],
    );

    tearDown(() {
      imageDetailsCubit?.close();
      mockNasaApodRepository = null;
    });
  });

  group('Nasa APOD repository test', () {
    setUp(() {
      mockNasaApodRepository = MockNasaApodRepository();
    });

    test('Test fetch Apod from mock repository', () async {
      when(mockNasaApodRepository.fetchPictureOfDay())
          .thenAnswer((_) async => mockApod);

      final PictureOfDay pictureOfDay =
          await mockNasaApodRepository.fetchPictureOfDay();

      expect(pictureOfDay, mockApod);
    });

    tearDown(() {
      mockNasaApodRepository = null;
    });
  });
}
