import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';
import 'package:hello_universe/src/data/apod.dart';
import 'package:hello_universe/src/data/apod_service.dart';
import 'package:hello_universe/src/data/media_type.dart';
import 'package:hello_universe/src/data/serializer.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../test_doubles/test_models.dart';
import 'apod_service_test.mocks.dart';

late _ArrangeBuilder _builder;

@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  final apod = TestModels.apod(title: 'x-1', mediaType: MediaType.other);
  final apod2 = TestModels.apod(title: 'y-2', mediaType: MediaType.image);
  final apodListJson = json.encode([apod.toJson(), apod2.toJson()]);
  final apodJson = json.encode(apod.toJson());

  late ChopperClient chopperClient;

  setUp(() {
    _builder = _ArrangeBuilder();
    chopperClient = ChopperClient(
      client: _builder.mockHttpClient,
      converter: BuiltValueConverter(serializers),
    );
  });

  tearDown(() {
    _builder.mockHttpClient.close();
  });

  group('$ApodServiceProvider', () {
    test('can be created', () {
      final tested = RealApodServiceProvider(chopperClient: chopperClient);

      expect(tested, isA<ApodServiceProvider>());
    });

    test('returns an $ApodService on create', () {
      final tested = RealApodServiceProvider(chopperClient: chopperClient);

      final service = tested.create();

      expect(service, isA<ApodService>());
    });

    test('passes $ChopperClient to the $ApodService', () {
      final tested = RealApodServiceProvider(chopperClient: chopperClient);

      final service = tested.create();

      expect(service.client, chopperClient);
    });
  });

  group('fetchImageList', () {
    test('has correct path', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY',
        startDate: '2020-01-23',
        endDate: '2030-01-23',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.path, '/planetary/apod');
    });

    test('has http GET method', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY',
        startDate: '2020-01-23',
        endDate: '2030-01-23',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.method, 'GET');
    });

    test('has api key as query parameter', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY-xx1',
        startDate: '2020-01-23',
        endDate: '2030-01-23',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['api_key'], 'TEST_KEY-xx1');
    });

    test('has start date as query parameter', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY-xx1',
        startDate: '2000-01-01',
        endDate: '2026-01-23',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['start_date'], '2000-01-01');
    });

    test('has end date as query parameter', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY-xx1',
        startDate: '2026-01-23',
        endDate: '2050-01-01',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['end_date'], '2050-01-01');
    });

    test('has thumbs as query parameter', () async {
      _builder.withHttpClientSend(
        Stream.fromIterable([utf8.encode(apodListJson)]),
      );
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImageList(
        apiKey: 'TEST_KEY-xx1',
        startDate: '2020-01-23',
        endDate: '2030-01-23',
        includeThumbnails: true,
      );

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['thumbs'], 'true');
    });

    group('on error', () {
      test('is not successful', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode('')]),
          statusCode: 400,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImageList(
          apiKey: 'TEST_KEY',
          startDate: '2026-01-23',
          endDate: '2026-01-23',
          includeThumbnails: true,
        );

        expect(response.isSuccessful, isFalse);
        expect(response.statusCode, 400);
      });

      test('throws error', () async {
        const error = 'error-xx3';
        _builder.withHttpClientSend(Stream.error(error), statusCode: 404);
        final tested = _builder.createTested(chopperClient);

        expect(
          () => tested.fetchImageList(
            apiKey: 'TEST_KEY',
            startDate: '2026-01-23',
            endDate: '2026-01-23',
            includeThumbnails: true,
          ),
          throwsA(error),
        );
      });
    });

    group('on success', () {
      test('returns a ${Response<BuiltList<Apod>>}', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode(apodListJson)]),
          statusCode: 200,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImageList(
          apiKey: 'TEST_KEY',
          startDate: '2026-01-23',
          endDate: '2026-01-23',
          includeThumbnails: true,
        );

        expect(response, isA<Response<BuiltList<Apod>>>());
      });

      test('maps response correctly', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode(apodListJson)]),
          statusCode: 200,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImageList(
          apiKey: 'TEST_KEY',
          startDate: '2026-01-23',
          endDate: '2026-01-23',
          includeThumbnails: true,
        );

        expect(response.body, [apod, apod2]);
      });
    });
  });

  group('fetchImage', () {
    test('has correct path', () async {
      _builder.withHttpClientSend(Stream.fromIterable([utf8.encode(apodJson)]));
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImage(apiKey: 'TEST_KEY', includeThumbnails: true);

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.path, '/planetary/apod');
    });

    test('has http GET method', () async {
      _builder.withHttpClientSend(Stream.fromIterable([utf8.encode(apodJson)]));
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImage(apiKey: 'TEST_KEY', includeThumbnails: true);

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.method, 'GET');
    });

    test('has api key as query parameter', () async {
      _builder.withHttpClientSend(Stream.fromIterable([utf8.encode(apodJson)]));
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImage(apiKey: 'TEST_KEY-x2', includeThumbnails: true);

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['api_key'], 'TEST_KEY-x2');
    });

    test('has thumbs as query parameter', () async {
      _builder.withHttpClientSend(Stream.fromIterable([utf8.encode(apodJson)]));
      final tested = _builder.createTested(chopperClient);

      await tested.fetchImage(apiKey: 'TEST_KEY', includeThumbnails: true);

      final request =
          verify(_builder.mockHttpClient.send(captureAny)).captured.single
              as http.BaseRequest;
      expect(request.url.queryParameters['thumbs'], 'true');
    });

    group('on error', () {
      test('is not successful', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode('')]),
          statusCode: 400,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImage(
          apiKey: 'TEST_KEY',
          includeThumbnails: true,
        );

        expect(response.isSuccessful, isFalse);
        expect(response.statusCode, 400);
      });

      test('throws error', () async {
        const error = 'error-x7';
        _builder.withHttpClientSend(Stream.error(error), statusCode: 400);
        final tested = _builder.createTested(chopperClient);

        expect(
          () => tested.fetchImage(apiKey: 'TEST_KEY', includeThumbnails: true),
          throwsA(error),
        );
      });
    });

    group('on success', () {
      test('returns a ${Response<Apod>}', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode(apodJson)]),
          statusCode: 200,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImage(
          apiKey: 'TEST_KEY',
          includeThumbnails: true,
        );

        expect(response, isA<Response<Apod>>());
      });

      test('maps response correctly', () async {
        _builder.withHttpClientSend(
          Stream.fromIterable([utf8.encode(apodJson)]),
          statusCode: 200,
        );
        final tested = _builder.createTested(chopperClient);

        final response = await tested.fetchImage(
          apiKey: 'TEST_KEY',
          includeThumbnails: true,
        );

        expect(response.body, apod);
      });
    });
  });
}

class _ArrangeBuilder {
  final mockHttpClient = MockHttpClient();

  void withHttpClientSend(Stream<List<int>> response, {int? statusCode}) {
    when(mockHttpClient.send(any)).thenAnswer(
      (invocation) async => http.StreamedResponse(response, statusCode ?? 200),
    );
  }

  ApodService createTested(ChopperClient chopperClient) =>
      RealApodServiceProvider(chopperClient: chopperClient).create();
}
