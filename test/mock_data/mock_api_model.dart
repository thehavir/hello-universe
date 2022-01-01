import 'package:hello_universe/models/model.dart';

/// Mock data for the response of fetching picture of day api
/// (https://api.nasa.gov/planetary/apod).
final PictureOfDay mockApod = PictureOfDay(
  copyright: 'mock1 copyright',
  date: 'mock1 date',
  explanation: 'mock1 explanation',
  hdurl: 'mock1 hdurl',
  mediaType: MediaType.image,
  serviceVersion: 'mock1 serviceVersion',
  title: 'mock1 title',
  url: 'mock1 url',
);

/// Mock data for the response of fetching picture of day api
/// (https://api.nasa.gov/planetary/apod).
final PictureOfDay mockApod2 = PictureOfDay(
  copyright: 'mock2 copyright',
  date: 'mock2 date',
  explanation: 'mock2 explanation',
  hdurl: 'mock2 hdurl',
  mediaType: MediaType.image,
  serviceVersion: 'mock2 serviceVersion',
  title: 'mock2 title',
  url: 'mock2 url',
);

/// Mock data for the response of fetching picture of day api
/// (https://api.nasa.gov/planetary/apod).
final PictureOfDay mockApod3 = PictureOfDay(
  copyright: 'mock3 copyright',
  date: 'mock3 date',
  explanation: 'mock3 explanation',
  hdurl: 'mock3 hdurl',
  mediaType: MediaType.image,
  serviceVersion: 'mock3 serviceVersion',
  title: 'mock3 title',
  url: 'mock3 url',
);

/// Mock data for the response of fetching list of the picture of day api
/// (https://api.nasa.gov/planetary/apod).
final List<PictureOfDay> mockApodList = <PictureOfDay>[
  mockApod,
  mockApod2,
  mockApod3,
];

/// Mock data for the response of fetching list of the picture of day api
/// (https://api.nasa.gov/planetary/apod).
final List<PictureOfDay> mockApodList2 = <PictureOfDay>[
  mockApod3,
  mockApod2,
  mockApod,
];
