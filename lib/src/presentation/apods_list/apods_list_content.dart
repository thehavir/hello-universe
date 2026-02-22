import 'package:flutter/material.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/apods_list/components/apod_card.dart';
import 'package:hello_universe/src/presentation/apods_list/components/bottom_loader.dart';
import 'package:hello_universe/src/presentation/apods_list/components/empty_content.dart';
import 'package:hello_universe/src/presentation/apods_list/components/error_content.dart';
import 'package:hello_universe/src/presentation/apods_list/components/first_page_progress_indicator.dart';
import 'package:hello_universe/src/presentation/apods_list/components/new_page_error_indicator.dart';
import 'package:hello_universe/src/presentation/apods_list/components/no_more_item_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApodsListContent extends StatelessWidget {
  const ApodsListContent({
    required this.apodPages,
    required this.apodPageKeys,
    required this.hasNextPage,
    required this.isLoading,
    required this.error,
    required this.onFetchNextPage,
    required this.onRetry,
    required this.onApodTap,
    super.key,
  });

  final List<List<Apod>>? apodPages;
  final List<ApodsPageKey>? apodPageKeys;
  final bool hasNextPage;
  final bool isLoading;
  final Object? error;
  final VoidCallback onFetchNextPage;
  final VoidCallback onRetry;
  final ValueSetter<Apod> onApodTap;

  @override
  Widget build(BuildContext context) => PagedListView<ApodsPageKey, Apod>(
    padding: const .symmetric(horizontal: 16),
    state: PagingState<ApodsPageKey, Apod>(
      error: error,
      hasNextPage: hasNextPage,
      isLoading: isLoading,
      pages: apodPages,
      keys: apodPageKeys,
    ),
    fetchNextPage: onFetchNextPage,
    builderDelegate: PagedChildBuilderDelegate(
      itemBuilder: (_, apod, index) => Column(
        children: [
          if (index == 0) const SizedBox(height: 16),
          ApodCard(apod: apod, onApodTap: () => onApodTap(apod)),
          const SizedBox(height: 8),
        ],
      ),
      firstPageErrorIndicatorBuilder: (context) =>
          ErrorContent(error: error, onRetry: onRetry),
      firstPageProgressIndicatorBuilder: (context) =>
          const FirstPageProgressIndicator(),
      newPageErrorIndicatorBuilder: (context) =>
          NewPageErrorIndicator(onRetry: onRetry),
      newPageProgressIndicatorBuilder: (context) => const BottomLoader(),
      noItemsFoundIndicatorBuilder: (context) => const EmptyContent(),
      noMoreItemsIndicatorBuilder: (context) => const NoMoreItemsIndicator(),
    ),
  );
}
