import 'package:hello_universe/src/routes.dart';
import 'package:test/test.dart';

void main() {
  test('${Routes.apodsListScreen} is set to apods-list-screen', () {
    expect(Routes.apodsListScreen, 'apods-list-screen');
  });

  test('${Routes.apodDetailsScreen} is set to apod-details-screen', () {
    expect(Routes.apodDetailsScreen, 'apod-details-screen');
  });

  test('${Routes.imageFullScreen} is set to image-full-screen', () {
    expect(Routes.imageFullScreen, 'image-full-screen');
  });
}
