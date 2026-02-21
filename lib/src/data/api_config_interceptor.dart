import 'dart:async';

import 'package:chopper/chopper.dart';

const _apiKey = 'api_key';

abstract class ConfigRequestInterceptor implements Interceptor {}

class ConfigRequestInterceptorImpl implements ConfigRequestInterceptor {
  const ConfigRequestInterceptorImpl();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    final parameters = Map<String, dynamic>.from(request.parameters)
      ..addAll({_apiKey: 'DEMO_KEY'});
    final newRequest = request.copyWith(parameters: parameters);

    return chain.proceed(newRequest);
  }
}
