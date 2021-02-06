import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/bloc/apod_cubit.dart';
import 'package:hello_universe/model/picture_of_day.dart';
import 'package:hello_universe/repository/MockNasaApodRepository.dart';

void main() {
  final MockNasaApodRepository mockNasaApodRepository =
  MockNasaApodRepository();

  group('APOD Cubit test', () {
    ApodCubit apodCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      apodCubit = ApodCubit(mockNasaApodRepository);
    });

    test('First state is [ApodInitial]', () {
      expect(apodCubit.state, const ApodInitial());
    });

    blocTest<ApodCubit, ApodState>(
      'Test fetch nasa apod',
      build: () => apodCubit,
      act: (cubit) => cubit.fetchApod(),
      expect: [
        ApodLoading(),
        ApodLoaded(mockApod),
      ],
    );

    tearDown(() {
      apodCubit?.close();
    });
  });

  group('Nasa APOD repository test', () {
    test('Test fetch Apod from repository', () async {
      final PictureOfDay pictureOfDay =
      await mockNasaApodRepository.fetchPictureOfDay();

      expect(pictureOfDay, mockApod);
    });
  });
}
