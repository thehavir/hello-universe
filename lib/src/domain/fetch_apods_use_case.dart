import 'package:fpdart/fpdart.dart';
import 'package:hello_universe/src/domain/entities/apod_page.dart';
import 'package:hello_universe/src/domain/entities/apods_error.dart';
import 'package:hello_universe/src/domain/entities/apods_page_key.dart';
import 'package:hello_universe/src/domain/apods_pagination_handler.dart';
import 'package:hello_universe/src/domain/apods_repository.dart';
import 'package:hello_universe/src/domain/date_time_extension.dart';

abstract class FetchApodsUseCase {
  TaskEither<ApodsError, ApodPage> execute({
    required ApodsPageKey? currentPageKey,
  });
}

class FetchApodsUseCaseImpl implements FetchApodsUseCase {
  const FetchApodsUseCaseImpl({
    required ApodsRepository apodsRepository,
    required ApodsPaginationHandler apodsPaginationHandler,
  }) : _apodsRepository = apodsRepository,
       _apodsPaginationHandler = apodsPaginationHandler;

  final ApodsRepository _apodsRepository;
  final ApodsPaginationHandler _apodsPaginationHandler;

  @override
  TaskEither<ApodsError, ApodPage> execute({
    required ApodsPageKey? currentPageKey,
  }) {
    final nextPageKey = _apodsPaginationHandler.nextPageKey(currentPageKey);
    final result = _apodsRepository.fetchApods(
      startDate: nextPageKey.startDate.format(),
      endDate: nextPageKey.endDate.format(),
      includeThumbnails: true,
    );

    return result.map((apods) => ApodPage(apods: apods, pageKey: nextPageKey));
  }
}
