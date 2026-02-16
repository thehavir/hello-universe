import 'package:chopper/chopper.dart';
import 'package:hello_universe/src/data/api_config_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'api_config_interceptor_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateMocks([Chain<String>])
void main() {
  setUp(() => _builder = _ArrangeBuilder());

  test('can be created', () {
    final tested = _builder.createTested();

    expect(tested, isA<ConfigRequestInterceptor>());
  });

  test('is an $Interceptor', () {
    final tested = _builder.createTested();

    expect(tested, isA<Interceptor>());
  });

  test('adds api_key parameter to the request', () async {
    final initialParams = <String, dynamic>{'test1': 'value2'};
    final originalRequest = Request(
      'GET',
      Uri.parse('https://base.url'),
      Uri.parse('/path/url'),
      parameters: initialParams,
    );
    final chain = MockChain<String>();
    final response = Response<String>(http.Response('', 200), 'dummy_body');
    provideDummy<Request>(originalRequest);
    provideDummy<Response<String>>(response);
    when(chain.request).thenReturn(originalRequest);
    when(chain.proceed(any)).thenAnswer((_) async => response);
    final tested = _builder.createTested();

    await tested.intercept(chain);

    final captured =
        verify(chain.proceed(captureAny)).captured.single as Request;
    expect(captured.parameters, <String, dynamic>{
      ...initialParams,
      'api_key': 'DEMO_KEY',
    });
  });
}

class _ArrangeBuilder {
  ConfigRequestInterceptor createTested() =>
      const ConfigRequestInterceptorImpl();
}
