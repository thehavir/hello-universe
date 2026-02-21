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
      ..addAll({_apiKey: '9nYkpIbzx45SPXpXC7TzDj8qYMshH9zODzEJ1UXf'});
    final newRequest = request.copyWith(parameters: parameters);

    return chain.proceed(newRequest);
  }
}
