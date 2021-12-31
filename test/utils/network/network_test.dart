import 'package:flutter_test/flutter_test.dart';
import 'package:hello_universe/utils/network/network.dart';
import 'package:http/http.dart';

void main() {
  group('Test utils.network', () {
    const String testBaseUrl = 'reqbin.com';
    const String testPath = '/echo';
    final HttpClient client = HttpClient(Client());

    test('Test successfully send a request and receive a response', () async {
      final Response response = await client.request(
        authority: testBaseUrl,
        path: testPath,
      );

      expect(response.body, isNotEmpty);
    });

    test('Test successfully send a request with a statusCode', () async {
      final Response response = await client.request(
        authority: testBaseUrl,
        path: testPath,
      );

      expect(response.statusCode, isNotNull);
      print('Response statusCode: ${response.statusCode}');
    });
  });
}
