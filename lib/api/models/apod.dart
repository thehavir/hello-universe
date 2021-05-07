/// Data model class for Nasa astronomy picture of day.
class PictureOfDay {
  /// Constructor of `PictureOfDay` class.
  PictureOfDay({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  /// Constructs a `PictureOfDay` instance from a json that is the response of
  /// the server.
  PictureOfDay.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    date = json['date'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }

  /// The copyright of the image/video.
  String copyright;

  /// The date of the APOD image/video that is posted on the Nasa website.
  String date;

  /// The explanation of the image/video.
  String explanation;

  /// The HD url of the image/video.
  String hdurl;

  /// The media type. It can be `image` or `video`.
  String mediaType;

  /// The api service version.
  String serviceVersion;

  /// The title of the image/video.
  String title;

  /// The url of the image/video.
  String url;

  /// Creates a json object from a `PictureOfDay` object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['copyright'] = copyright;
    data['date'] = date;
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType;
    data['service_version'] = serviceVersion;
    data['title'] = title;
    data['url'] = url;

    return data;
  }
}
