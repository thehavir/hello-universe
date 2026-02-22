import 'package:hello_universe/src/paths.dart';
import 'package:test/test.dart';

void main() {
  test('${Paths.apodsListScreen} is set to /apods-list-screen', () {
    expect(Paths.apodsListScreen, '/apods-list-screen');
  });

  test('${Paths.imageDetails} is set to /image-details', () {
    expect(Paths.imageDetails, '/image-details');
  });

  test('${Paths.imageFullScreen} is set to /image-full-screen', () {
    expect(Paths.imageFullScreen, '/image-full-screen');
  });
}
