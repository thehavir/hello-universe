import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/bloc/apod_cubit.dart';

void main() {
  test('First state is InitialState', () {
    final ApodCubit apodCubit = ApodCubit();
    expect(apodCubit.state.runtimeType, ApodInitial);
  });

  test('Fetch Nasa Apod (the latest picture)', () async {
    final ApodCubit apodCubit = ApodCubit();
    final response = await apodCubit.fetchApod();
    expect(response, 'picture');
  });
}
