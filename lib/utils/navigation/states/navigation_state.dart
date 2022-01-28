part of 'navigation_cubit.dart';

/// Defines what types of page states the app can be in. If the app is in the
/// `none` state, nothing needs to be done. If it is in the `addPage` state,
/// then a page needs to be added. To pop a page, set the page state to `pop`.
enum PageState {
  none,
  addPage,
  addAll,
  addWidget,
  pop,
  replace,
  replaceAll,
}

/// Wraps several items that allow the router to handle a page action. If the
/// state is `addPage`, the page field will have the new page to add. The page,
/// pages and widget are all optional fields and each are used differently
/// depending on the page state.
class PageAction {
  PageAction({
    this.pageState = PageState.none,
    this.pages,
    this.page,
    this.pageData,
    this.widget,
  });

  /// State of the page. Base on this state, router should do an action.
  PageState pageState;

  /// Configuration of the page.
  PageConfiguration? page;

  /// List of the pages.
  List<PageConfiguration>? pages;

  /// Data that is needed for creating the page.
  dynamic pageData;

  /// Widget that we want to push it.
  Widget? widget;
}

/// The state of the navigation
/// It's data is `PageAction`. Also, it holds extra data (`PictureOfDay` in this
/// case), in order to pass it to the page.
class NavigationState extends BaseState<PageAction> {
  /// Constructs a `NavigationState`.
  const NavigationState({
    PageAction? pageAction,
  }) : super(data: pageAction);

  /// Returns current `PageState`.
  PageState? get pageState => data?.pageState;

  /// Returns current page.
  PageConfiguration? get page => data?.page;

  /// Returns pages list.
  List<PageConfiguration>? get pages => data?.pages;

  /// Returns PageAction's `pageData`.
  dynamic get pageData => data?.pageData;

  @override
  NavigationState copyWith({
    StateStatus? status = StateStatus.initial,
    PageAction? data,
    Object? error,
  }) =>
      NavigationState(
        pageAction: data ?? this.data,
      );
}
