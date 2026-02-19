import 'package:clock/clock.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/features/image_list/extensions/date_extension.dart';
import 'package:hello_universe/src/repository/constants.dart';

abstract class ApodsPaginationHandler {
  ApodsPageKey nextPageKey(ApodsPageKey? currentPageKey);
}

class ApodsPaginationHandlerImpl implements ApodsPaginationHandler {
  const ApodsPaginationHandlerImpl({required Clock clock}) : _clock = clock;

  final Clock _clock;

  @override
  ApodsPageKey nextPageKey(ApodsPageKey? currentPageKey) {
    if (currentPageKey == null) {
      return _firstPageKey();
    }

    return _nexPageKey(currentPageKey);
  }

  ApodsPageKey _firstPageKey() => _pageKey(_clock.now());

  ApodsPageKey _nexPageKey(ApodsPageKey currentPageKey) =>
      _pageKey(currentPageKey.startDate);

  ApodsPageKey _pageKey(DateTime currentStartDate) {
    final endDate = currentStartDate.xDaysBefore(1);
    if (!endDate.isAfter(firstImageDate)) {
      return ApodsPageKey(
        startDate: firstImageDate,
        endDate: firstImageDate,
        isLastPage: true,
      );
    }

    // ignore: avoid_redundant_argument_values
    final potentialStartDate = endDate.xDaysBefore(20);
    final isLastPage = !potentialStartDate.isAfter(firstImageDate);
    final startDate = isLastPage ? firstImageDate : potentialStartDate;

    return ApodsPageKey(
      startDate: startDate,
      endDate: endDate,
      isLastPage: isLastPage,
    );
  }
}
