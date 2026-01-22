extension NullableObjectExt on Object? {
  T forceCast<T>() {
    if (this is T) {
      return this as T;
    }
    throw ArgumentError.value(this);
  }
}
