/// A Disposable is a source or destination of data that can be disposed.

abstract interface class Disposable {
  /// The dispose method is invoked to release resources that the object
  /// is holding (such as open streams).
  void dispose();
}
