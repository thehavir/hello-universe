import 'package:fpdart/fpdart.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/data/models/apod_dto_extension.dart';
import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/apods_repository.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';

class ApodsRepositoryImpl implements ApodsRepository {
  const ApodsRepositoryImpl({required ApodService apodService})
    : _apodService = apodService;

  final ApodService _apodService;

  @override
  TaskEither<ApodsError, List<Apod>> fetchApods({
    required String startDate,
    required String endDate,
    required bool includeThumbnails,
  }) => TaskEither.tryCatch(
    () async => (await _apodService.fetchImageList(
      startDate: startDate,
      endDate: endDate,
      includeThumbnails: includeThumbnails,
    )).map((data) => data.toEntity()).toList(),
    ApodsError.new,
  );
}
