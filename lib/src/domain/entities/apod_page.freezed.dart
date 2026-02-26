// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApodPage {

 List<Apod> get apods; ApodsPageKey get pageKey;
/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodPageCopyWith<ApodPage> get copyWith => _$ApodPageCopyWithImpl<ApodPage>(this as ApodPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApodPage&&const DeepCollectionEquality().equals(other.apods, apods)&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apods),pageKey);

@override
String toString() {
  return 'ApodPage(apods: $apods, pageKey: $pageKey)';
}


}

/// @nodoc
abstract mixin class $ApodPageCopyWith<$Res>  {
  factory $ApodPageCopyWith(ApodPage value, $Res Function(ApodPage) _then) = _$ApodPageCopyWithImpl;
@useResult
$Res call({
 List<Apod> apods, ApodsPageKey pageKey
});


$ApodsPageKeyCopyWith<$Res> get pageKey;

}
/// @nodoc
class _$ApodPageCopyWithImpl<$Res>
    implements $ApodPageCopyWith<$Res> {
  _$ApodPageCopyWithImpl(this._self, this._then);

  final ApodPage _self;
  final $Res Function(ApodPage) _then;

/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apods = null,Object? pageKey = null,}) {
  return _then(_self.copyWith(
apods: null == apods ? _self.apods : apods // ignore: cast_nullable_to_non_nullable
as List<Apod>,pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as ApodsPageKey,
  ));
}
/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApodsPageKeyCopyWith<$Res> get pageKey {
  
  return $ApodsPageKeyCopyWith<$Res>(_self.pageKey, (value) {
    return _then(_self.copyWith(pageKey: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApodPage].
extension ApodPagePatterns on ApodPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApodPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApodPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApodPage value)  $default,){
final _that = this;
switch (_that) {
case _ApodPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApodPage value)?  $default,){
final _that = this;
switch (_that) {
case _ApodPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Apod> apods,  ApodsPageKey pageKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApodPage() when $default != null:
return $default(_that.apods,_that.pageKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Apod> apods,  ApodsPageKey pageKey)  $default,) {final _that = this;
switch (_that) {
case _ApodPage():
return $default(_that.apods,_that.pageKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Apod> apods,  ApodsPageKey pageKey)?  $default,) {final _that = this;
switch (_that) {
case _ApodPage() when $default != null:
return $default(_that.apods,_that.pageKey);case _:
  return null;

}
}

}

/// @nodoc


class _ApodPage implements ApodPage {
  const _ApodPage({required final  List<Apod> apods, required this.pageKey}): _apods = apods;
  

 final  List<Apod> _apods;
@override List<Apod> get apods {
  if (_apods is EqualUnmodifiableListView) return _apods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apods);
}

@override final  ApodsPageKey pageKey;

/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodPageCopyWith<_ApodPage> get copyWith => __$ApodPageCopyWithImpl<_ApodPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApodPage&&const DeepCollectionEquality().equals(other._apods, _apods)&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_apods),pageKey);

@override
String toString() {
  return 'ApodPage(apods: $apods, pageKey: $pageKey)';
}


}

/// @nodoc
abstract mixin class _$ApodPageCopyWith<$Res> implements $ApodPageCopyWith<$Res> {
  factory _$ApodPageCopyWith(_ApodPage value, $Res Function(_ApodPage) _then) = __$ApodPageCopyWithImpl;
@override @useResult
$Res call({
 List<Apod> apods, ApodsPageKey pageKey
});


@override $ApodsPageKeyCopyWith<$Res> get pageKey;

}
/// @nodoc
class __$ApodPageCopyWithImpl<$Res>
    implements _$ApodPageCopyWith<$Res> {
  __$ApodPageCopyWithImpl(this._self, this._then);

  final _ApodPage _self;
  final $Res Function(_ApodPage) _then;

/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apods = null,Object? pageKey = null,}) {
  return _then(_ApodPage(
apods: null == apods ? _self._apods : apods // ignore: cast_nullable_to_non_nullable
as List<Apod>,pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as ApodsPageKey,
  ));
}

/// Create a copy of ApodPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApodsPageKeyCopyWith<$Res> get pageKey {
  
  return $ApodsPageKeyCopyWith<$Res>(_self.pageKey, (value) {
    return _then(_self.copyWith(pageKey: value));
  });
}
}

// dart format on
