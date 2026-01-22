import 'package:hello_universe/src/paths.dart';
import 'package:test/test.dart';

void main() {
  test('${Paths.splash} is set to /splash', () {
    expect(Paths.splash, '/splash');
  });

  test('${Paths.imageList} is set to /image-list', () {
    expect(Paths.imageList, '/image-list');
  });

  test('${Paths.imageDetails} is set to /image-details', () {
    expect(Paths.imageDetails, '/image-details');
  });

  test('${Paths.imageFullScreen} is set to /image-full-screen', () {
    expect(Paths.imageFullScreen, '/image-full-screen');
  });
}
