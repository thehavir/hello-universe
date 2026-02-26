// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apods_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApodsError {

 Object get error; StackTrace get stackTrace;
/// Create a copy of ApodsError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodsErrorCopyWith<ApodsError> get copyWith => _$ApodsErrorCopyWithImpl<ApodsError>(this as ApodsError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApodsError&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'ApodsError(error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ApodsErrorCopyWith<$Res>  {
  factory $ApodsErrorCopyWith(ApodsError value, $Res Function(ApodsError) _then) = _$ApodsErrorCopyWithImpl;
@useResult
$Res call({
 Object error, StackTrace stackTrace
});




}
/// @nodoc
class _$ApodsErrorCopyWithImpl<$Res>
    implements $ApodsErrorCopyWith<$Res> {
  _$ApodsErrorCopyWithImpl(this._self, this._then);

  final ApodsError _self;
  final $Res Function(ApodsError) _then;

/// Create a copy of ApodsError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? stackTrace = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error ,stackTrace: null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}

}


/// Adds pattern-matching-related methods to [ApodsError].
extension ApodsErrorPatterns on ApodsError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApodsError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApodsError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApodsError value)  $default,){
final _that = this;
switch (_that) {
case _ApodsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApodsError value)?  $default,){
final _that = this;
switch (_that) {
case _ApodsError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object error,  StackTrace stackTrace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApodsError() when $default != null:
return $default(_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object error,  StackTrace stackTrace)  $default,) {final _that = this;
switch (_that) {
case _ApodsError():
return $default(_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object error,  StackTrace stackTrace)?  $default,) {final _that = this;
switch (_that) {
case _ApodsError() when $default != null:
return $default(_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _ApodsError implements ApodsError {
  const _ApodsError(this.error, this.stackTrace);
  

@override final  Object error;
@override final  StackTrace stackTrace;

/// Create a copy of ApodsError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodsErrorCopyWith<_ApodsError> get copyWith => __$ApodsErrorCopyWithImpl<_ApodsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApodsError&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'ApodsError(error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$ApodsErrorCopyWith<$Res> implements $ApodsErrorCopyWith<$Res> {
  factory _$ApodsErrorCopyWith(_ApodsError value, $Res Function(_ApodsError) _then) = __$ApodsErrorCopyWithImpl;
@override @useResult
$Res call({
 Object error, StackTrace stackTrace
});




}
/// @nodoc
class __$ApodsErrorCopyWithImpl<$Res>
    implements _$ApodsErrorCopyWith<$Res> {
  __$ApodsErrorCopyWithImpl(this._self, this._then);

  final _ApodsError _self;
  final $Res Function(_ApodsError) _then;

/// Create a copy of ApodsError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = null,}) {
  return _then(_ApodsError(
null == error ? _self.error : error ,null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,
  ));
}


}

// dart format on
