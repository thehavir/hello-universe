import 'package:hello_universe/utils/navigation/states/navigation_cubit.dart';

/// Define the paths or routes of each screen.
/// Path of the `ImageListPage`.
const String imageListPath = '/imageList';

/// Path of the `ImageDetailsPage`.
const String imageDetailsPath = '/imageDetails';

/// Represents the UI for each page as enum.
enum Pages {
  imageList,
  imageDetails,
}

/// Wraps all information about each page together.
/// Holds two Strings, which represent the page’s `key` and `path`. And then a
/// third parameter which represents the UI associated th that page using thePageAction
/// `Pages` enum. The fourth item remembers the current page action that was
/// used for this page.
class PageConfiguration {
  PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.currentPageAction,
  });

  /// Keys of the page.
  final String key;

  /// Path of the page.
  final String path;

  /// The UI associated with that page.
  final Pages uiPage;

  /// Current `PageAction`.
  PageAction? currentPageAction;
}

/// Route configuration of `ImageListPage`.
final PageConfiguration imageListPageConfig = PageConfiguration(
  key: 'ImageList',
  path: imageListPath,
  uiPage: Pages.imageList,
);

/// Route configuration of `ImageDetailsPage`.
final PageConfiguration imageDetailsPageConfig = PageConfiguration(
  key: 'ImageDetails',
  path: imageDetailsPath,
  uiPage: Pages.imageDetails,
);
