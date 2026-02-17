import 'package:hello_universe/src/domain/apods_error.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:fpdart/fpdart.dart';

abstract class ApodsRepository {
  TaskEither<ApodsError, List<Apod>> fetchApods({
    required String startDate,
    required String endDate,
    required bool includeThumbnails,
  });
}
