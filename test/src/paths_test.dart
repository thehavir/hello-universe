import 'package:hello_universe/src/paths.dart';
import 'package:test/test.dart';

void main() {
  test('${Paths.apodsListScreen} is set to /apods-list-screen', () {
    expect(Paths.apodsListScreen, '/apods-list-screen');
  });

  test('${Paths.apodDetailsScreen} is set to /apod-details-screen', () {
    expect(Paths.apodDetailsScreen, '/apod-details-screen');
  });

  test('${Paths.apodFullSizeScreen} is set to /apod-full-size-screen', () {
    expect(Paths.apodFullSizeScreen, '/apod-full-size-screen');
  });
}
