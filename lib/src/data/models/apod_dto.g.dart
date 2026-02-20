// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApodDto> _$apodDtoSerializer = _$ApodDtoSerializer();

class _$ApodDtoSerializer implements StructuredSerializer<ApodDto> {
  @override
  final Iterable<Type> types = const [ApodDto, _$ApodDto];
  @override
  final String wireName = 'ApodDto';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ApodDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'explanation',
      serializers.serialize(
        object.explanation,
        specifiedType: const FullType(String),
      ),
      'media_type',
      serializers.serialize(
        object.mediaType,
        specifiedType: const FullType(MediaTypeDto),
      ),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'service_version',
      serializers.serialize(
        object.serviceVersion,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.hdUrl;
    if (value != null) {
      result
        ..add('hdurl')
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
    value = object.copyright;
    if (value != null) {
      result
        ..add('copyright')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  ApodDto deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApodDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'date':
          result.date =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'explanation':
          result.explanation =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'media_type':
          result.mediaType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(MediaTypeDto),
                  )!
                  as MediaTypeDto;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'hdurl':
          result.hdUrl =
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
        case 'copyright':
          result.copyright =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'service_version':
          result.serviceVersion =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ApodDto extends ApodDto {
  @override
  final String date;
  @override
  final String title;
  @override
  final String explanation;
  @override
  final MediaTypeDto mediaType;
  @override
  final String url;
  @override
  final String? hdUrl;
  @override
  final String? thumbnailUrl;
  @override
  final String? copyright;
  @override
  final String serviceVersion;

  factory _$ApodDto([void Function(ApodDtoBuilder)? updates]) =>
      (ApodDtoBuilder()..update(updates))._build();

  _$ApodDto._({
    required this.date,
    required this.title,
    required this.explanation,
    required this.mediaType,
    required this.url,
    this.hdUrl,
    this.thumbnailUrl,
    this.copyright,
    required this.serviceVersion,
  }) : super._();
  @override
  ApodDto rebuild(void Function(ApodDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApodDtoBuilder toBuilder() => ApodDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApodDto &&
        date == other.date &&
        title == other.title &&
        explanation == other.explanation &&
        mediaType == other.mediaType &&
        url == other.url &&
        hdUrl == other.hdUrl &&
        thumbnailUrl == other.thumbnailUrl &&
        copyright == other.copyright &&
        serviceVersion == other.serviceVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, mediaType.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, hdUrl.hashCode);
    _$hash = $jc(_$hash, thumbnailUrl.hashCode);
    _$hash = $jc(_$hash, copyright.hashCode);
    _$hash = $jc(_$hash, serviceVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApodDto')
          ..add('date', date)
          ..add('title', title)
          ..add('explanation', explanation)
          ..add('mediaType', mediaType)
          ..add('url', url)
          ..add('hdUrl', hdUrl)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('copyright', copyright)
          ..add('serviceVersion', serviceVersion))
        .toString();
  }
}

class ApodDtoBuilder implements Builder<ApodDto, ApodDtoBuilder> {
  _$ApodDto? _$v;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  MediaTypeDto? _mediaType;
  MediaTypeDto? get mediaType => _$this._mediaType;
  set mediaType(MediaTypeDto? mediaType) => _$this._mediaType = mediaType;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _hdUrl;
  String? get hdUrl => _$this._hdUrl;
  set hdUrl(String? hdUrl) => _$this._hdUrl = hdUrl;

  String? _thumbnailUrl;
  String? get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String? thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  String? _copyright;
  String? get copyright => _$this._copyright;
  set copyright(String? copyright) => _$this._copyright = copyright;

  String? _serviceVersion;
  String? get serviceVersion => _$this._serviceVersion;
  set serviceVersion(String? serviceVersion) =>
      _$this._serviceVersion = serviceVersion;

  ApodDtoBuilder();

  ApodDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _title = $v.title;
      _explanation = $v.explanation;
      _mediaType = $v.mediaType;
      _url = $v.url;
      _hdUrl = $v.hdUrl;
      _thumbnailUrl = $v.thumbnailUrl;
      _copyright = $v.copyright;
      _serviceVersion = $v.serviceVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApodDto other) {
    _$v = other as _$ApodDto;
  }

  @override
  void update(void Function(ApodDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApodDto build() => _build();

  _$ApodDto _build() {
    final _$result =
        _$v ??
        _$ApodDto._(
          date: BuiltValueNullFieldError.checkNotNull(date, r'ApodDto', 'date'),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'ApodDto',
            'title',
          ),
          explanation: BuiltValueNullFieldError.checkNotNull(
            explanation,
            r'ApodDto',
            'explanation',
          ),
          mediaType: BuiltValueNullFieldError.checkNotNull(
            mediaType,
            r'ApodDto',
            'mediaType',
          ),
          url: BuiltValueNullFieldError.checkNotNull(url, r'ApodDto', 'url'),
          hdUrl: hdUrl,
          thumbnailUrl: thumbnailUrl,
          copyright: copyright,
          serviceVersion: BuiltValueNullFieldError.checkNotNull(
            serviceVersion,
            r'ApodDto',
            'serviceVersion',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
