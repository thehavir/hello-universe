class PictureOfDay {
  String copyright;
  String date;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['copyright'] = this.copyright;
    data['date'] = this.date;
    data['explanation'] = this.explanation;
    data['hdurl'] = this.hdurl;
    data['media_type'] = this.mediaType;
    data['service_version'] = this.serviceVersion;
    data['title'] = this.title;
    data['url'] = this.url;

    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureOfDay &&
          runtimeType == other.runtimeType &&
          copyright == other.copyright &&
          date == other.date &&
          explanation == other.explanation &&
          hdurl == other.hdurl &&
          mediaType == other.mediaType &&
          serviceVersion == other.serviceVersion &&
          title == other.title &&
          url == other.url;

  @override
  int get hashCode =>
      copyright.hashCode ^
      date.hashCode ^
      explanation.hashCode ^
      hdurl.hashCode ^
      mediaType.hashCode ^
      serviceVersion.hashCode ^
      title.hashCode ^
      url.hashCode;
}
