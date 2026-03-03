// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod_full_size_screen_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApodFullSizeScreenArguments {

 String get url; DateTime get date;
/// Create a copy of ApodFullSizeScreenArguments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodFullSizeScreenArgumentsCopyWith<ApodFullSizeScreenArguments> get copyWith => _$ApodFullSizeScreenArgumentsCopyWithImpl<ApodFullSizeScreenArguments>(this as ApodFullSizeScreenArguments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApodFullSizeScreenArguments&&(identical(other.url, url) || other.url == url)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,url,date);

@override
String toString() {
  return 'ApodFullSizeScreenArguments(url: $url, date: $date)';
}


}

/// @nodoc
abstract mixin class $ApodFullSizeScreenArgumentsCopyWith<$Res>  {
  factory $ApodFullSizeScreenArgumentsCopyWith(ApodFullSizeScreenArguments value, $Res Function(ApodFullSizeScreenArguments) _then) = _$ApodFullSizeScreenArgumentsCopyWithImpl;
@useResult
$Res call({
 String url, DateTime date
});




}
/// @nodoc
class _$ApodFullSizeScreenArgumentsCopyWithImpl<$Res>
    implements $ApodFullSizeScreenArgumentsCopyWith<$Res> {
  _$ApodFullSizeScreenArgumentsCopyWithImpl(this._self, this._then);

  final ApodFullSizeScreenArguments _self;
  final $Res Function(ApodFullSizeScreenArguments) _then;

/// Create a copy of ApodFullSizeScreenArguments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? date = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ApodFullSizeScreenArguments].
extension ApodFullSizeScreenArgumentsPatterns on ApodFullSizeScreenArguments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApodFullSizeScreenArguments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApodFullSizeScreenArguments value)  $default,){
final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApodFullSizeScreenArguments value)?  $default,){
final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments() when $default != null:
return $default(_that.url,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments():
return $default(_that.url,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _ApodFullSizeScreenArguments() when $default != null:
return $default(_that.url,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _ApodFullSizeScreenArguments implements ApodFullSizeScreenArguments {
  const _ApodFullSizeScreenArguments({required this.url, required this.date});
  

@override final  String url;
@override final  DateTime date;

/// Create a copy of ApodFullSizeScreenArguments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodFullSizeScreenArgumentsCopyWith<_ApodFullSizeScreenArguments> get copyWith => __$ApodFullSizeScreenArgumentsCopyWithImpl<_ApodFullSizeScreenArguments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApodFullSizeScreenArguments&&(identical(other.url, url) || other.url == url)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,url,date);

@override
String toString() {
  return 'ApodFullSizeScreenArguments(url: $url, date: $date)';
}


}

/// @nodoc
abstract mixin class _$ApodFullSizeScreenArgumentsCopyWith<$Res> implements $ApodFullSizeScreenArgumentsCopyWith<$Res> {
  factory _$ApodFullSizeScreenArgumentsCopyWith(_ApodFullSizeScreenArguments value, $Res Function(_ApodFullSizeScreenArguments) _then) = __$ApodFullSizeScreenArgumentsCopyWithImpl;
@override @useResult
$Res call({
 String url, DateTime date
});




}
/// @nodoc
class __$ApodFullSizeScreenArgumentsCopyWithImpl<$Res>
    implements _$ApodFullSizeScreenArgumentsCopyWith<$Res> {
  __$ApodFullSizeScreenArgumentsCopyWithImpl(this._self, this._then);

  final _ApodFullSizeScreenArguments _self;
  final $Res Function(_ApodFullSizeScreenArguments) _then;

/// Create a copy of ApodFullSizeScreenArguments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? date = null,}) {
  return _then(_ApodFullSizeScreenArguments(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
