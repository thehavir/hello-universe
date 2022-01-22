import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_universe/features/image_detail/view/image_details_page.dart';
import 'package:hello_universe/features/image_list/presentation/image_list_page.dart';
import 'package:hello_universe/utils/navigation/router/ui_pages.dart';
import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

/// Represents the app’s RouterDelegate, `AppRouterDelegate`. It extends the
/// abstract [RouterDelegate], which produces a configuration for each Route.
/// This configuration is `PageConfiguration`.
class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with PopNavigatorRouterDelegateMixin<PageConfiguration> {
  /// Constructs `AppRouterDelegate`.
  AppRouterDelegate({
    required this.navigatorKey,
    required this.navigationCubit,
  });

  /// Key of the navigator that used for retrieving the current navigator of
  /// the Router.
  /// `PopNavigatorRouterDelegateMixin` requires this key.
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// Instance of `NavigationCubit` that manage navigation state.
  final NavigationCubit navigationCubit;

  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function
  int get numPages => _pages.length;

  final List<Page> _pages = [];

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        observers: [HeroController()],
        onPopPage: _onPopPage,
        pages: _buildPages(),
      );

  /// Will be called on AppBar's back button.
  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);

    if (!didPop) {
      return false;
    }

    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  /// Removes last page if can pop.
  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  /// Determine if length of the pages is more than 1, so the last page can be
  /// removed.
  bool canPop() => _pages.length > 1;

  void _removePage(Page page) {
    _pages.remove(page);

    navigationCubit.resetCurrentAction();
  }

  /// Will be called on device's back button.
  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);

      return Future.value(true);
    }

    return Future.value(false);
  }

  List<Page> _buildPages() {
    final PageState? pageState = navigationCubit.state.pageState;

    if (pageState != null) {
      switch (pageState) {
        case PageState.none:
          break;
        case PageState.addPage:
          _setPageAction(navigationCubit.state.data!);
          addPage(navigationCubit.state.page!);
          break;
        case PageState.pop:
          pop();
          break;
        case PageState.replace:
          _setPageAction(navigationCubit.state.data!);
          replace(navigationCubit.state.page!);
          break;
        case PageState.replaceAll:
          _setPageAction(navigationCubit.state.data!);
          replaceAll(navigationCubit.state.page!);
          break;
        case PageState.addWidget:
          _setPageAction(navigationCubit.state.data!);
          pushWidget(
              navigationCubit.state.data!.widget!, navigationCubit.state.page!);
          break;
        case PageState.addAll:
          addAll(navigationCubit.state.pages!);
          break;
      }
    }

    if (pageState != PageState.none) {
      navigationCubit.resetCurrentAction();
    }

    return List.of(_pages);
  }

  void _setPageAction(PageAction action) {
    switch (action.page!.uiPage) {
      case Pages.imageList:
        imageListPageConfig.currentPageAction = action;
        break;
      case Pages.imageDetails:
        imageDetailsPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  /// Adds a page to the pages.
  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.imageList:
          _addPageData(ImageListPage(), imageListPageConfig);
          break;
        case Pages.imageDetails:
          if (pageConfig.currentPageAction?.pageData != null) {
            _addPageData(
              ImageDetailsPage(apod: pageConfig.currentPageAction!.pageData!),
              pageConfig,
            );
          }
          break;
        default:
          break;
      }
    }
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) => _pages.add(
        _createPage(child, pageConfig),
      );

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) =>
      MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig,
      );

  /// Replaces the latest page (`PageConfiguration`).
  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }

    addPage(newRoute);
  }

  /// Clears pages and adds new page (`PageConfiguration`).
  void replaceAll(PageConfiguration newRoute) => setNewRoutePath(newRoute);

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;

    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }

    return SynchronousFuture(null);
  }

  /// Adds new page on top of the pages.
  void push(PageConfiguration newRoute) => addPage(newRoute);

  /// Adds new widget on top of the pages.
  void pushWidget(Widget child, PageConfiguration newRoute) =>
      _addPageData(child, newRoute);

  /// Clears pages and adds a list pages (`PageConfiguration`).
  void addAll(List<PageConfiguration> routes) {
    _pages.clear();

    routes.forEach((route) {
      addPage(route);
    });
  }

  /// Clears the entire navigation stack, i.e. the _pages list, and adds all the
  /// new pages provided as the argument.
  /// When we want to go to a page and change the path, we use this method.
  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  /// Because states are managed by Cubit, there is no need for this.
  @override
  void addListener(VoidCallback listener) {}

  /// Because states are managed by Cubit, there is no need for this.
  @override
  void removeListener(VoidCallback listener) {}
}
