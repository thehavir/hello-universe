import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/features/image_list/cubit/image_list_cubit.dart';
import 'package:hello_universe/repository/fake_api_data.dart';
import 'package:hello_universe/repository/nasa_apod_repository.dart';
import 'package:mockito/mockito.dart';

class MockNasaApodRepository extends Mock implements NasaApodRepository {}

void main() {
  NasaApodRepository mockNasaApodRepository;

  group('Test image list cubit', () {
    ImageListCubit imageListCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      mockNasaApodRepository = MockNasaApodRepository();
      imageListCubit = ImageListCubit(mockNasaApodRepository);
    });

    test('Test first state is [ImageListStateInitial]', () {
      assert(imageListCubit.state is ImageListStateInitial);
    });

    blocTest<ImageListCubit, ImageListState>(
      'Test fetch image list from a specific date is successful',
      build: () {
        when(mockNasaApodRepository.fetchImageList(
          startDate: 'mock2 date',
          endDate: 'mock3 date',
        )).thenAnswer((_) async => mockApodList);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetchImageList(
        startDate: 'mock2 date',
        endDate: 'mock3 date',
      ),
      expect: () => <ImageListState>[
        const ImageListStateLoading(),
        ImageListStateLoaded(mockApodList),
      ],
    );

    blocTest<ImageListCubit, ImageListState>(
      'Test fetched image list is a valid image list',
      build: () {
        when(mockNasaApodRepository.fetchImageList(
          startDate: 'mock1 date',
          endDate: 'mock3 date',
        )).thenAnswer((_) async => mockApodList);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetchImageList(
        startDate: 'mock1 date',
        endDate: 'mock3 date',
      ),
      expect: () => <ImageListState>[
        const ImageListStateLoading(),
        ImageListStateLoaded(mockApodList),
      ],
      verify: (ImageListCubit cubit) {
        List<PictureOfDay> imageList = <PictureOfDay>[];
        final ImageListState state = cubit.state;

        if (state is ImageListStateLoaded) {
          imageList = state.imageList;
        }

        expect(imageList.isNotEmpty, true);
        expect(imageList.first.url, 'mock1 url');
      },
    );

    blocTest<ImageListCubit, ImageListState>(
      'Test fetch image list is failed',
      build: () {
        when(mockNasaApodRepository.fetchImageList(
          startDate: 'startDate',
          endDate: 'endDate',
        )).thenThrow(mockNasaApodApiErrorMessage);

        return imageListCubit;
      },
      act: (ImageListCubit cubit) => cubit.fetchImageList(
        startDate: 'startDate',
        endDate: 'endDate',
      ),
      expect: () => <ImageListState>[
        const ImageListStateLoading(),
        ImageListStateFailed(mockNasaApodApiErrorMessage),
      ],
    );

    tearDown(() {
      imageListCubit?.close();
      mockNasaApodRepository = null;
    });
  });
}
