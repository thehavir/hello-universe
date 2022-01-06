import 'package:bloc_test/bloc_test.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';

class MockImageListCubit extends MockCubit<ImageListState>
    implements ImageListCubit {}
