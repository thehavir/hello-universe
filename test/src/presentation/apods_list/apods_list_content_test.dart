import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/src/domain/entities/apods_page_key.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/presentation/apods_list/apods_list_content.dart';
import 'package:hello_universe/src/presentation/apods_list/components/apod_card.dart';
import 'package:hello_universe/src/presentation/apods_list/components/bottom_loader.dart';
import 'package:hello_universe/src/presentation/apods_list/components/empty_content.dart';
import 'package:hello_universe/src/presentation/apods_list/components/error_content.dart';
import 'package:hello_universe/src/presentation/apods_list/components/first_page_progress_indicator.dart';
import 'package:hello_universe/src/presentation/apods_list/components/new_page_error_indicator.dart';
import 'package:hello_universe/src/presentation/apods_list/components/no_more_item_indicator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../test_doubles/test_models.dart';
import '../../../test_utils/mock_context.mocks.dart';

void main() {
  late BuildContext context;

  setUp(() => context = MockBuildContext());

  testWidgets('can be created', (tester) async {
    await tester.pumpTested();

    expect(find.byType(ApodsListContent), findsOneWidget);
  });

  testWidgets('has $PagedListView', (tester) async {
    await tester.pumpTested();

    expect(find.byType(PagedListView<ApodsPageKey, Apod>), findsOneWidget);
  });

  testWidgets('$PagedListView has $PagingState', (tester) async {
    await tester.pumpTested();

    final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
      find.byType(PagedListView<ApodsPageKey, Apod>),
    );
    expect(widget.state, isA<PagingState>());
  });

  testWidgets('$PagingState has error', (tester) async {
    const error = 'Asteroid buzzing by!';
    await tester.pumpTested(error: error);

    final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
      find.byType(PagedListView<ApodsPageKey, Apod>),
    );
    expect(widget.state.error, error);
  });

  [true, false].forEach((hasNextPage) {
    testWidgets('$PagingState has hasNextPage as $hasNextPage', (tester) async {
      await tester.pumpTested(hasNextPage: hasNextPage);

      final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
        find.byType(PagedListView<ApodsPageKey, Apod>),
      );
      expect(widget.state.hasNextPage, hasNextPage);
    });
  });

  [true, false].forEach((isLoading) {
    testWidgets('$PagingState has isLoading as $isLoading', (tester) async {
      await tester.pumpTested(isLoading: isLoading);

      final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
        find.byType(PagedListView<ApodsPageKey, Apod>),
      );
      expect(widget.state.isLoading, isLoading);
    });
  });

  testWidgets('$PagingState has pages as ${List<List<Apod>>}', (tester) async {
    final apodPages = [
      [TestModels.apod(title: '1'), TestModels.apod(title: '2')],
      [TestModels.apod(title: '3')],
    ];
    final apodPageKeys = [TestModels.apodsPageKey(), TestModels.apodsPageKey()];
    await tester.pumpTested(apodPages: apodPages, apodPageKeys: apodPageKeys);

    final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
      find.byType(PagedListView<ApodsPageKey, Apod>),
    );
    expect(widget.state.pages, apodPages);
  });

  testWidgets('$PagingState has keys as ${List<ApodsPageKey>}', (tester) async {
    final apodPages = [
      [TestModels.apod(), TestModels.apod()],
      [TestModels.apod()],
    ];
    final apodPageKeys = [
      TestModels.apodsPageKey(isLastPage: false),
      TestModels.apodsPageKey(isLastPage: true),
    ];
    await tester.pumpTested(apodPages: apodPages, apodPageKeys: apodPageKeys);

    final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
      find.byType(PagedListView<ApodsPageKey, Apod>),
    );
    expect(widget.state.keys, apodPageKeys);
  });

  testWidgets('passes onFetchNextPage to $PagedListView', (tester) async {
    final callback = () => null;
    await tester.pumpTested(onFetchNextPage: callback);

    final widget = tester.widget<PagedListView<ApodsPageKey, Apod>>(
      find.byType(PagedListView<ApodsPageKey, Apod>),
    );
    expect(widget.fetchNextPage, callback);
  });

  testWidgets('$PagedListView has a $ApodCard as itemBuilder for each $Apod', (
    tester,
  ) async {
    final apod1 = TestModels.apod(title: '1');
    final apod2 = TestModels.apod(title: '2');
    final apodPages = [
      [apod1],
      [apod2],
    ];
    final apodPageKeys = [
      TestModels.apodsPageKey(isLastPage: false),
      TestModels.apodsPageKey(isLastPage: true),
    ];
    await tester.pumpTested(apodPages: apodPages, apodPageKeys: apodPageKeys);

    final widget1 =
        tester.findPagedChildBuilderDelegate().itemBuilder(context, apod1, 0)
            as Column;
    final widget2 =
        tester.findPagedChildBuilderDelegate().itemBuilder(context, apod2, 1)
            as Column;
    expect(widget1.children, contains(isA<ApodCard>()));
    expect(widget2.children, contains(isA<ApodCard>()));
  });

  testWidgets('passes $Apod to $ApodCard', (tester) async {
    final apod1 = TestModels.apod(title: '1');
    final apod2 = TestModels.apod(title: '2');
    final apodPages = [
      [apod1],
      [apod2],
    ];
    final apodPageKeys = [
      TestModels.apodsPageKey(isLastPage: false),
      TestModels.apodsPageKey(isLastPage: true),
    ];
    await tester.pumpTested(apodPages: apodPages, apodPageKeys: apodPageKeys);

    final widget =
        tester.findPagedChildBuilderDelegate().itemBuilder(context, apod2, 1)
            as Column;
    expect(
      widget.children.first,
      isA<ApodCard>().having((p) => p.apod, 'apod', apod2),
    );
  });

  testWidgets('passes onApodTap to $ApodCard', (tester) async {
    Apod? tappedApod;
    final apod1 = TestModels.apod(title: '1');
    final apod2 = TestModels.apod(title: '2');
    final apodPages = [
      [apod1],
      [apod2],
    ];
    final apodPageKeys = [
      TestModels.apodsPageKey(isLastPage: false),
      TestModels.apodsPageKey(isLastPage: true),
    ];
    await tester.pumpTested(
      apodPages: apodPages,
      apodPageKeys: apodPageKeys,
      onApodTap: (apod) => tappedApod = apod,
    );

    final widget =
        tester.findPagedChildBuilderDelegate().itemBuilder(context, apod2, 1)
            as Column;
    final apodCard = widget.children.first as ApodCard;
    apodCard.onApodTap();
    expect(tappedApod, apod2);
  });

  testWidgets(
    '$PagedListView has $ErrorContent as firstPageErrorIndicatorBuilder',
    (tester) async {
      await tester.pumpTested();

      final widget = tester
          .findPagedChildBuilderDelegate()
          .firstPageErrorIndicatorBuilder!(context);
      expect(widget, isA<ErrorContent>());
    },
  );

  testWidgets('passes error to $ErrorContent', (tester) async {
    const error = 'UFO discovery!';
    await tester.pumpTested(error: error);

    final widget =
        tester.findPagedChildBuilderDelegate().firstPageErrorIndicatorBuilder!(
              context,
            )
            as ErrorContent;
    expect(widget.error, error);
  });

  testWidgets('passes onRetry to $ErrorContent', (tester) async {
    final callback = () => null;
    await tester.pumpTested(onRetry: callback);

    final widget =
        tester.findPagedChildBuilderDelegate().firstPageErrorIndicatorBuilder!(
              context,
            )
            as ErrorContent;
    expect(widget.onRetry, callback);
  });

  testWidgets('$PagedListView has $FirstPageProgressIndicator '
      'as firstPageProgressIndicatorBuilder', (tester) async {
    await tester.pumpTested();

    final widget = tester
        .findPagedChildBuilderDelegate()
        .firstPageProgressIndicatorBuilder!(context);
    expect(widget, isA<FirstPageProgressIndicator>());
  });

  testWidgets('$PagedListView has $NewPageErrorIndicator '
      'as newPageErrorIndicatorBuilder', (tester) async {
    await tester.pumpTested();

    final widget = tester
        .findPagedChildBuilderDelegate()
        .newPageErrorIndicatorBuilder!(context);
    expect(widget, isA<NewPageErrorIndicator>());
  });

  testWidgets('passes onRetry to the $NewPageErrorIndicator ', (tester) async {
    final callback = () => null;
    await tester.pumpTested(onRetry: callback);

    final widget =
        tester.findPagedChildBuilderDelegate().newPageErrorIndicatorBuilder!(
              context,
            )
            as NewPageErrorIndicator;
    expect(widget.onRetry, callback);
  });

  testWidgets('$PagedListView has $BottomLoader '
      'as newPageProgressIndicatorBuilder', (tester) async {
    await tester.pumpTested();

    final widget = tester
        .findPagedChildBuilderDelegate()
        .newPageProgressIndicatorBuilder!(context);
    expect(widget, isA<BottomLoader>());
  });

  testWidgets('$PagedListView has $EmptyContent '
      'as noItemsFoundIndicatorBuilder', (tester) async {
    await tester.pumpTested();

    final widget = tester
        .findPagedChildBuilderDelegate()
        .noItemsFoundIndicatorBuilder!(context);
    expect(widget, isA<EmptyContent>());
  });

  testWidgets('$PagedListView has $NoMoreItemsIndicator '
      'as noMoreItemsIndicatorBuilder', (tester) async {
    await tester.pumpTested();

    final widget = tester
        .findPagedChildBuilderDelegate()
        .noMoreItemsIndicatorBuilder!(context);
    expect(widget, isA<NoMoreItemsIndicator>());
  });
}

extension on WidgetTester {
  Future<void> pumpTested({
    List<List<Apod>>? apodPages,
    List<ApodsPageKey>? apodPageKeys,
    bool? hasNextPage,
    bool? isLoading,
    Object? error,
    VoidCallback? onFetchNextPage,
    VoidCallback? onRetry,
    ValueSetter<Apod>? onApodTap,
  }) => pumpWidget(
    MaterialApp(
      home: ApodsListContent(
        apodPages: apodPages,
        apodPageKeys: apodPageKeys,
        hasNextPage: hasNextPage ?? false,
        isLoading: isLoading ?? false,
        error: error,
        onFetchNextPage: onFetchNextPage ?? () {},
        onRetry: onRetry ?? () {},
        onApodTap: onApodTap ?? (_) {},
      ),
    ),
  );

  PagedChildBuilderDelegate<Apod> findPagedChildBuilderDelegate() {
    final widgetFinder = find.byType(PagedListView<ApodsPageKey, Apod>);
    final pagedChildBuilderDelegate =
        widgetList<PagedListView<ApodsPageKey, Apod>>(widgetFinder).first;
    return pagedChildBuilderDelegate.builderDelegate;
  }
}
