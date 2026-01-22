import 'package:hello_universe/src/routes.dart';
import 'package:test/test.dart';

void main() {
  test('${Routes.splash} is set to splash', () {
    expect(Routes.splash, 'splash');
  });

  test('${Routes.imageList} is set to image-list', () {
    expect(Routes.imageList, 'image-list');
  });

  test('${Routes.imageDetails} is set to image-details', () {
    expect(Routes.imageDetails, 'image-details');
  });

  test('${Routes.imageFullScreen} is set to image-full-screen', () {
    expect(Routes.imageFullScreen, 'image-full-screen');
  });
}
