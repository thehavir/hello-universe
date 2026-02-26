import 'package:hello_universe/src/routes.dart';
import 'package:test/test.dart';

void main() {
  test('${Routes.apodsListScreen} is set to apods-list-screen', () {
    expect(Routes.apodsListScreen, 'apods-list-screen');
  });

  test('${Routes.apodDetailsScreen} is set to apod-details-screen', () {
    expect(Routes.apodDetailsScreen, 'apod-details-screen');
  });

  test('${Routes.apodFullSizeScreen} is set to apod-full-size-screen', () {
    expect(Routes.apodFullSizeScreen, 'apod-full-size-screen');
  });
}
