// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:hello_universe/src/data/apod.dart';

part 'apod_service.chopper.dart';

@ChopperApi()
abstract class ApodService extends ChopperService {
  @Get(path: '/planetary/apod')
  Future<Response<Apod>> fetchImage({
    @Query('thumbs') required bool includeThumbnails,
  });

  @Get(path: '/planetary/apod')
  Future<Response<BuiltList<Apod>>> fetchImageList({
    @Query('start_date') required String startDate,
    @Query('end_date') required String endDate,
    @Query('thumbs') required bool includeThumbnails,
  });
}

abstract class ApodServiceProvider {
  ApodService create();
}

class RealApodServiceProvider implements ApodServiceProvider {
  RealApodServiceProvider({required ChopperClient chopperClient})
    : _chopperClient = chopperClient;

  final ChopperClient _chopperClient;

  @override
  ApodService create() => _$ApodService(_chopperClient);
}
