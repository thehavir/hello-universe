import 'package:hello_universe/src/features/image_list/states/image_list_cubit.dart';
import 'package:mocktail/mocktail.dart';

mixin ImageListCubitBuilderMixin {
  ImageListCubit imageListCubit = _MockImageListCubit();

  void arrangeImageListCubit() {
    when(() => imageListCubit.state).thenAnswer((_) => const ImageListState());
    when(
      () => imageListCubit.stream,
    ).thenAnswer((_) => Stream.value(const ImageListState()));
    when(() => imageListCubit.fetch()).thenAnswer((_) => Future.value());
    when(() => imageListCubit.close()).thenAnswer((_) => Future.value());
  }
}

class _MockImageListCubit extends Mock implements ImageListCubit {}
