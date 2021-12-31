import 'package:hello_universe/models/media_type.dart';

/// Data model class for Nasa astronomy picture of day.
class PictureOfDay {
  /// Constructs a `PictureOfDay`.
  PictureOfDay({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  /// Constructs a `PictureOfDay` instance from a json file.
  PictureOfDay.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    date = json['date'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'] == 'image'
        ? MediaType.image
        : MediaType.video;
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnail_url'];
  }

  /// The copyright of the image/video.
  String? copyright;

  /// The date of the APOD image/video that is posted on the Nasa website.
  String? date;

  /// The explanation of the image/video.
  String? explanation;

  /// The HD url of the image/video.
  String? hdurl;

  /// The media type. It can be `image` or `video`.
  MediaType? mediaType;

  /// The api service version.
  String? serviceVersion;

  /// The title of the image/video.
  String? title;

  /// The url of the image/video.
  String? url;

  /// If Apod was a video, then this shows the thumbnail of that video.
  String? thumbnailUrl;

  /// Creates a json object from a `PictureOfDay` object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['copyright'] = copyright;
    data['date'] = date;
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType == MediaType.image ? 'image' : 'video';
    data['service_version'] = serviceVersion;
    data['title'] = title;
    data['url'] = url;
    data['thumbnail_url'] = thumbnailUrl;

    return data;
  }
}

