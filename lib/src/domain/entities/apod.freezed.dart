// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Apod {

 DateTime? get date; String? get title; String? get explanation; String? get copyright; MediaType get mediaType; String? get url; String? get hdUrl; String? get thumbnailUrl; String? get serviceVersion;
/// Create a copy of Apod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodCopyWith<Apod> get copyWith => _$ApodCopyWithImpl<Apod>(this as Apod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Apod&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.hdUrl, hdUrl) || other.hdUrl == hdUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.serviceVersion, serviceVersion) || other.serviceVersion == serviceVersion));
}


@override
int get hashCode => Object.hash(runtimeType,date,title,explanation,copyright,mediaType,url,hdUrl,thumbnailUrl,serviceVersion);

@override
String toString() {
  return 'Apod(date: $date, title: $title, explanation: $explanation, copyright: $copyright, mediaType: $mediaType, url: $url, hdUrl: $hdUrl, thumbnailUrl: $thumbnailUrl, serviceVersion: $serviceVersion)';
}


}

/// @nodoc
abstract mixin class $ApodCopyWith<$Res>  {
  factory $ApodCopyWith(Apod value, $Res Function(Apod) _then) = _$ApodCopyWithImpl;
@useResult
$Res call({
 DateTime? date, String? title, String? explanation, String? copyright, MediaType mediaType, String? url, String? hdUrl, String? thumbnailUrl, String? serviceVersion
});




}
/// @nodoc
class _$ApodCopyWithImpl<$Res>
    implements $ApodCopyWith<$Res> {
  _$ApodCopyWithImpl(this._self, this._then);

  final Apod _self;
  final $Res Function(Apod) _then;

/// Create a copy of Apod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? title = freezed,Object? explanation = freezed,Object? copyright = freezed,Object? mediaType = null,Object? url = freezed,Object? hdUrl = freezed,Object? thumbnailUrl = freezed,Object? serviceVersion = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,hdUrl: freezed == hdUrl ? _self.hdUrl : hdUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,serviceVersion: freezed == serviceVersion ? _self.serviceVersion : serviceVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Apod].
extension ApodPatterns on Apod {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Apod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Apod() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Apod value)  $default,){
final _that = this;
switch (_that) {
case _Apod():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Apod value)?  $default,){
final _that = this;
switch (_that) {
case _Apod() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  String? title,  String? explanation,  String? copyright,  MediaType mediaType,  String? url,  String? hdUrl,  String? thumbnailUrl,  String? serviceVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Apod() when $default != null:
return $default(_that.date,_that.title,_that.explanation,_that.copyright,_that.mediaType,_that.url,_that.hdUrl,_that.thumbnailUrl,_that.serviceVersion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  String? title,  String? explanation,  String? copyright,  MediaType mediaType,  String? url,  String? hdUrl,  String? thumbnailUrl,  String? serviceVersion)  $default,) {final _that = this;
switch (_that) {
case _Apod():
return $default(_that.date,_that.title,_that.explanation,_that.copyright,_that.mediaType,_that.url,_that.hdUrl,_that.thumbnailUrl,_that.serviceVersion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  String? title,  String? explanation,  String? copyright,  MediaType mediaType,  String? url,  String? hdUrl,  String? thumbnailUrl,  String? serviceVersion)?  $default,) {final _that = this;
switch (_that) {
case _Apod() when $default != null:
return $default(_that.date,_that.title,_that.explanation,_that.copyright,_that.mediaType,_that.url,_that.hdUrl,_that.thumbnailUrl,_that.serviceVersion);case _:
  return null;

}
}

}

/// @nodoc


class _Apod implements Apod {
  const _Apod({required this.date, required this.title, required this.explanation, required this.copyright, required this.mediaType, required this.url, required this.hdUrl, required this.thumbnailUrl, required this.serviceVersion});
  

@override final  DateTime? date;
@override final  String? title;
@override final  String? explanation;
@override final  String? copyright;
@override final  MediaType mediaType;
@override final  String? url;
@override final  String? hdUrl;
@override final  String? thumbnailUrl;
@override final  String? serviceVersion;

/// Create a copy of Apod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodCopyWith<_Apod> get copyWith => __$ApodCopyWithImpl<_Apod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Apod&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.copyright, copyright) || other.copyright == copyright)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.hdUrl, hdUrl) || other.hdUrl == hdUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.serviceVersion, serviceVersion) || other.serviceVersion == serviceVersion));
}


@override
int get hashCode => Object.hash(runtimeType,date,title,explanation,copyright,mediaType,url,hdUrl,thumbnailUrl,serviceVersion);

@override
String toString() {
  return 'Apod(date: $date, title: $title, explanation: $explanation, copyright: $copyright, mediaType: $mediaType, url: $url, hdUrl: $hdUrl, thumbnailUrl: $thumbnailUrl, serviceVersion: $serviceVersion)';
}


}

/// @nodoc
abstract mixin class _$ApodCopyWith<$Res> implements $ApodCopyWith<$Res> {
  factory _$ApodCopyWith(_Apod value, $Res Function(_Apod) _then) = __$ApodCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, String? title, String? explanation, String? copyright, MediaType mediaType, String? url, String? hdUrl, String? thumbnailUrl, String? serviceVersion
});




}
/// @nodoc
class __$ApodCopyWithImpl<$Res>
    implements _$ApodCopyWith<$Res> {
  __$ApodCopyWithImpl(this._self, this._then);

  final _Apod _self;
  final $Res Function(_Apod) _then;

/// Create a copy of Apod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? title = freezed,Object? explanation = freezed,Object? copyright = freezed,Object? mediaType = null,Object? url = freezed,Object? hdUrl = freezed,Object? thumbnailUrl = freezed,Object? serviceVersion = freezed,}) {
  return _then(_Apod(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,hdUrl: freezed == hdUrl ? _self.hdUrl : hdUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,serviceVersion: freezed == serviceVersion ? _self.serviceVersion : serviceVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
