import 'package:flutter/material.dart';
import 'package:hello_universe/src/assets.dart';
import 'package:hello_universe/src/domain/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/features/core/widgets/empty_page.dart';
import 'package:hello_universe/src/features/image_list/presentation/widgets/bottom_loader.dart';
import 'package:hello_universe/src/features/image_list/presentation/widgets/image_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApodsContent extends StatelessWidget {
  const ApodsContent({
    required this.apodPages,
    required this.apodPageKeys,
    required this.hasNextPage,
    required this.isLoading,
    required this.error,
    required this.onFetchNextPage,
    required this.onRetry,
    super.key,
  });

  final List<List<Apod>>? apodPages;
  final List<ApodsPageKey>? apodPageKeys;
  final bool hasNextPage;
  final bool isLoading;
  final Object? error;
  final VoidCallback onFetchNextPage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => PagedListView<ApodsPageKey, Apod>(
    state: PagingState<ApodsPageKey, Apod>(
      error: error,
      hasNextPage: hasNextPage,
      isLoading: isLoading,
      pages: apodPages,
      keys: apodPageKeys,
    ),
    fetchNextPage: onFetchNextPage,
    builderDelegate: PagedChildBuilderDelegate(
      itemBuilder: (_, apod, __) => ImageListItem(apod),
      firstPageErrorIndicatorBuilder: (context) => EmptyPage(
        title: 'Something went wrong\nFailed to load!\nerror:$error',
        assetsImage: Assets.errorIcon,
        actionButton: TextButton(
          onPressed: onRetry,
          child: const Text('Try again'),
        ),
      ),
      firstPageProgressIndicatorBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      newPageErrorIndicatorBuilder: (context) {
        print('*** Spinoza - error: $error');
        return TextButton(onPressed: onRetry, child: const Text('Retry'));
      },
      newPageProgressIndicatorBuilder: (context) => const BottomLoader(),
      noItemsFoundIndicatorBuilder: (context) => const EmptyPage(
        title: 'There is no Image!',
        assetsImage: Assets.noResultIcon,
      ),
      noMoreItemsIndicatorBuilder: (context) => const Padding(
        padding: .all(8),
        child: Center(child: Text('That was the last APOD!')),
      ),
    ),
  );
}
