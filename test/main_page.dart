import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/bloc/apod_cubit.dart';
import 'package:hello_universe/repository/MockNasaApodRepository.dart';

void main() {
  group('APOD Cubit test', () {
    ApodCubit apodCubit;
    MockNasaApodRepository mockNasaApodRepository;
    
    setUp(() {
      EquatableConfig.stringify = true;
      mockNasaApodRepository = MockNasaApodRepository();
      apodCubit = ApodCubit(mockNasaApodRepository);
    });

    tearDown((){
      apodCubit?.close();
    });
  });
}
