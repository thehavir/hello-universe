// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apods_page_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApodsPageKey {

 DateTime get startDate; DateTime get endDate; bool get isLastPage;
/// Create a copy of ApodsPageKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodsPageKeyCopyWith<ApodsPageKey> get copyWith => _$ApodsPageKeyCopyWithImpl<ApodsPageKey>(this as ApodsPageKey, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApodsPageKey&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isLastPage, isLastPage) || other.isLastPage == isLastPage));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,isLastPage);

@override
String toString() {
  return 'ApodsPageKey(startDate: $startDate, endDate: $endDate, isLastPage: $isLastPage)';
}


}

/// @nodoc
abstract mixin class $ApodsPageKeyCopyWith<$Res>  {
  factory $ApodsPageKeyCopyWith(ApodsPageKey value, $Res Function(ApodsPageKey) _then) = _$ApodsPageKeyCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate, bool isLastPage
});




}
/// @nodoc
class _$ApodsPageKeyCopyWithImpl<$Res>
    implements $ApodsPageKeyCopyWith<$Res> {
  _$ApodsPageKeyCopyWithImpl(this._self, this._then);

  final ApodsPageKey _self;
  final $Res Function(ApodsPageKey) _then;

/// Create a copy of ApodsPageKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = null,Object? endDate = null,Object? isLastPage = null,}) {
  return _then(_self.copyWith(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isLastPage: null == isLastPage ? _self.isLastPage : isLastPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApodsPageKey].
extension ApodsPageKeyPatterns on ApodsPageKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApodsPageKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApodsPageKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApodsPageKey value)  $default,){
final _that = this;
switch (_that) {
case _ApodsPageKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApodsPageKey value)?  $default,){
final _that = this;
switch (_that) {
case _ApodsPageKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  bool isLastPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApodsPageKey() when $default != null:
return $default(_that.startDate,_that.endDate,_that.isLastPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  bool isLastPage)  $default,) {final _that = this;
switch (_that) {
case _ApodsPageKey():
return $default(_that.startDate,_that.endDate,_that.isLastPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startDate,  DateTime endDate,  bool isLastPage)?  $default,) {final _that = this;
switch (_that) {
case _ApodsPageKey() when $default != null:
return $default(_that.startDate,_that.endDate,_that.isLastPage);case _:
  return null;

}
}

}

/// @nodoc


class _ApodsPageKey implements ApodsPageKey {
  const _ApodsPageKey({required this.startDate, required this.endDate, required this.isLastPage});
  

@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  bool isLastPage;

/// Create a copy of ApodsPageKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodsPageKeyCopyWith<_ApodsPageKey> get copyWith => __$ApodsPageKeyCopyWithImpl<_ApodsPageKey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApodsPageKey&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isLastPage, isLastPage) || other.isLastPage == isLastPage));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,isLastPage);

@override
String toString() {
  return 'ApodsPageKey(startDate: $startDate, endDate: $endDate, isLastPage: $isLastPage)';
}


}

/// @nodoc
abstract mixin class _$ApodsPageKeyCopyWith<$Res> implements $ApodsPageKeyCopyWith<$Res> {
  factory _$ApodsPageKeyCopyWith(_ApodsPageKey value, $Res Function(_ApodsPageKey) _then) = __$ApodsPageKeyCopyWithImpl;
@override @useResult
$Res call({
 DateTime startDate, DateTime endDate, bool isLastPage
});




}
/// @nodoc
class __$ApodsPageKeyCopyWithImpl<$Res>
    implements _$ApodsPageKeyCopyWith<$Res> {
  __$ApodsPageKeyCopyWithImpl(this._self, this._then);

  final _ApodsPageKey _self;
  final $Res Function(_ApodsPageKey) _then;

/// Create a copy of ApodsPageKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,Object? isLastPage = null,}) {
  return _then(_ApodsPageKey(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isLastPage: null == isLastPage ? _self.isLastPage : isLastPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
