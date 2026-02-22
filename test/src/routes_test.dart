import 'package:hello_universe/src/routes.dart';
import 'package:test/test.dart';

void main() {
  test('${Routes.apodsListScreen} is set to apods-list-screen', () {
    expect(Routes.apodsListScreen, 'apods-list-screen');
  });

  test('${Routes.imageDetails} is set to image-details', () {
    expect(Routes.imageDetails, 'image-details');
  });

  test('${Routes.imageFullScreen} is set to image-full-screen', () {
    expect(Routes.imageFullScreen, 'image-full-screen');
  });
}
