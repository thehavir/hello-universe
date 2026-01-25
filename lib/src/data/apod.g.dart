// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Apod> _$apodSerializer = _$ApodSerializer();

class _$ApodSerializer implements StructuredSerializer<Apod> {
  @override
  final Iterable<Type> types = const [Apod, _$Apod];
  @override
  final String wireName = 'Apod';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Apod object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.copyright;
    if (value != null) {
      result
        ..add('copyright')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.explanation;
    if (value != null) {
      result
        ..add('explanation')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.hdUrl;
    if (value != null) {
      result
        ..add('hdurl')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.mediaType;
    if (value != null) {
      result
        ..add('media_type')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(MediaType),
          ),
        );
    }
    value = object.serviceVersion;
    if (value != null) {
      result
        ..add('service_version')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.thumbnailUrl;
    if (value != null) {
      result
        ..add('thumbnail_url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  Apod deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApodBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'copyright':
          result.copyright =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'date':
          result.date =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'explanation':
          result.explanation =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'hdurl':
          result.hdUrl =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'media_type':
          result.mediaType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(MediaType),
                  )
                  as MediaType?;
          break;
        case 'service_version':
          result.serviceVersion =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'thumbnail_url':
          result.thumbnailUrl =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Apod extends Apod {
  @override
  final String? copyright;
  @override
  final String? date;
  @override
  final String? explanation;
  @override
  final String? hdUrl;
  @override
  final MediaType? mediaType;
  @override
  final String? serviceVersion;
  @override
  final String? title;
  @override
  final String? url;
  @override
  final String? thumbnailUrl;

  factory _$Apod([void Function(ApodBuilder)? updates]) =>
      (ApodBuilder()..update(updates))._build();

  _$Apod._({
    this.copyright,
    this.date,
    this.explanation,
    this.hdUrl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  }) : super._();
  @override
  Apod rebuild(void Function(ApodBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApodBuilder toBuilder() => ApodBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Apod &&
        copyright == other.copyright &&
        date == other.date &&
        explanation == other.explanation &&
        hdUrl == other.hdUrl &&
        mediaType == other.mediaType &&
        serviceVersion == other.serviceVersion &&
        title == other.title &&
        url == other.url &&
        thumbnailUrl == other.thumbnailUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, copyright.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, hdUrl.hashCode);
    _$hash = $jc(_$hash, mediaType.hashCode);
    _$hash = $jc(_$hash, serviceVersion.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Apod')
          ..add('copyright', copyright)
          ..add('date', date)
          ..add('explanation', explanation)
          ..add('hdUrl', hdUrl)
          ..add('mediaType', mediaType)
          ..add('serviceVersion', serviceVersion)
          ..add('title', title)
          ..add('url', url)
          ..add('thumbnailUrl', thumbnailUrl))
        .toString();
  }
}

class ApodBuilder implements Builder<Apod, ApodBuilder> {
  _$Apod? _$v;

  String? _copyright;
  String? get copyright => _$this._copyright;
  set copyright(String? copyright) => _$this._copyright = copyright;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  String? _hdUrl;
  String? get hdUrl => _$this._hdUrl;
  set hdUrl(String? hdUrl) => _$this._hdUrl = hdUrl;

  MediaType? _mediaType;
  MediaType? get mediaType => _$this._mediaType;
  set mediaType(MediaType? mediaType) => _$this._mediaType = mediaType;

  String? _serviceVersion;
  String? get serviceVersion => _$this._serviceVersion;
  set serviceVersion(String? serviceVersion) =>
      _$this._serviceVersion = serviceVersion;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  ApodBuilder();

  ApodBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _copyright = $v.copyright;
      _date = $v.date;
      _explanation = $v.explanation;
      _hdUrl = $v.hdUrl;
      _mediaType = $v.mediaType;
      _serviceVersion = $v.serviceVersion;
      _title = $v.title;
      _url = $v.url;
      _thumbnailUrl = $v.thumbnailUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Apod other) {
    _$v = other as _$Apod;
  }

  @override
  void update(void Function(ApodBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Apod build() => _build();

  _$Apod _build() {
    final _$result =
        _$v ??
        _$Apod._(
          copyright: copyright,
          date: date,
          explanation: explanation,
          hdUrl: hdUrl,
          mediaType: mediaType,
          serviceVersion: serviceVersion,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
