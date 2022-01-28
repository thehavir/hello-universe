part of 'image_list_cubit.dart';

/// State of `ImageListCubit`.
class ImageListState extends BaseState<List<Apod>> {
  /// Constructs a new ImageListState with the given parameters.
  const ImageListState({
    StateStatus? status = StateStatus.initial,
    List<Apod>? data,
    Object? error,
    this.offset = 0,
    this.hasMore = true,
    this.startDate,
  }) : super(
          status: status,
          data: data,
          error: error,
        );

  /// It is used for pagination.
  /// Offset of each repository call.
  final int offset;

  /// Shows if we reached to the end of the merchant list.
  /// As we have a size limit, we use this to show user proper message that s/he
  /// is reached to the end of the merchant list.
  final bool hasMore;

  /// Start date for fetch next Nasa Apod list from the API.
  /// It's the end date of previous Nasa APOD list.
  final DateTime? startDate;

  @override
  ImageListState copyWith({
    StateStatus? status = StateStatus.initial,
    List<Apod>? data,
    Object? error,
    int? offset,
    bool? hasMore,
    DateTime? startDate,
  }) =>
      ImageListState(
        status: status,
        data: data ?? this.data,
        error: error ?? this.error,
        offset: offset ?? this.offset,
        hasMore: hasMore ?? this.hasMore,
        startDate: startDate ?? this.startDate,
      );
}
