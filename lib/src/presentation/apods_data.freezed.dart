// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apods_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApodsData {

 List<List<Apod>> get apodPages; List<ApodsPageKey> get apodPageKeys; bool get hasNextPage;
/// Create a copy of ApodsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApodsDataCopyWith<ApodsData> get copyWith => _$ApodsDataCopyWithImpl<ApodsData>(this as ApodsData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApodsData&&const DeepCollectionEquality().equals(other.apodPages, apodPages)&&const DeepCollectionEquality().equals(other.apodPageKeys, apodPageKeys)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apodPages),const DeepCollectionEquality().hash(apodPageKeys),hasNextPage);

@override
String toString() {
  return 'ApodsData(apodPages: $apodPages, apodPageKeys: $apodPageKeys, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $ApodsDataCopyWith<$Res>  {
  factory $ApodsDataCopyWith(ApodsData value, $Res Function(ApodsData) _then) = _$ApodsDataCopyWithImpl;
@useResult
$Res call({
 List<List<Apod>> apodPages, List<ApodsPageKey> apodPageKeys, bool hasNextPage
});




}
/// @nodoc
class _$ApodsDataCopyWithImpl<$Res>
    implements $ApodsDataCopyWith<$Res> {
  _$ApodsDataCopyWithImpl(this._self, this._then);

  final ApodsData _self;
  final $Res Function(ApodsData) _then;

/// Create a copy of ApodsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apodPages = null,Object? apodPageKeys = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
apodPages: null == apodPages ? _self.apodPages : apodPages // ignore: cast_nullable_to_non_nullable
as List<List<Apod>>,apodPageKeys: null == apodPageKeys ? _self.apodPageKeys : apodPageKeys // ignore: cast_nullable_to_non_nullable
as List<ApodsPageKey>,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApodsData].
extension ApodsDataPatterns on ApodsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApodsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApodsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApodsData value)  $default,){
final _that = this;
switch (_that) {
case _ApodsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApodsData value)?  $default,){
final _that = this;
switch (_that) {
case _ApodsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<Apod>> apodPages,  List<ApodsPageKey> apodPageKeys,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApodsData() when $default != null:
return $default(_that.apodPages,_that.apodPageKeys,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<Apod>> apodPages,  List<ApodsPageKey> apodPageKeys,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _ApodsData():
return $default(_that.apodPages,_that.apodPageKeys,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<Apod>> apodPages,  List<ApodsPageKey> apodPageKeys,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _ApodsData() when $default != null:
return $default(_that.apodPages,_that.apodPageKeys,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc


class _ApodsData implements ApodsData {
  const _ApodsData({required final  List<List<Apod>> apodPages, required final  List<ApodsPageKey> apodPageKeys, required this.hasNextPage}): _apodPages = apodPages,_apodPageKeys = apodPageKeys;
  

 final  List<List<Apod>> _apodPages;
@override List<List<Apod>> get apodPages {
  if (_apodPages is EqualUnmodifiableListView) return _apodPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apodPages);
}

 final  List<ApodsPageKey> _apodPageKeys;
@override List<ApodsPageKey> get apodPageKeys {
  if (_apodPageKeys is EqualUnmodifiableListView) return _apodPageKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apodPageKeys);
}

@override final  bool hasNextPage;

/// Create a copy of ApodsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApodsDataCopyWith<_ApodsData> get copyWith => __$ApodsDataCopyWithImpl<_ApodsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApodsData&&const DeepCollectionEquality().equals(other._apodPages, _apodPages)&&const DeepCollectionEquality().equals(other._apodPageKeys, _apodPageKeys)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_apodPages),const DeepCollectionEquality().hash(_apodPageKeys),hasNextPage);

@override
String toString() {
  return 'ApodsData(apodPages: $apodPages, apodPageKeys: $apodPageKeys, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$ApodsDataCopyWith<$Res> implements $ApodsDataCopyWith<$Res> {
  factory _$ApodsDataCopyWith(_ApodsData value, $Res Function(_ApodsData) _then) = __$ApodsDataCopyWithImpl;
@override @useResult
$Res call({
 List<List<Apod>> apodPages, List<ApodsPageKey> apodPageKeys, bool hasNextPage
});




}
/// @nodoc
class __$ApodsDataCopyWithImpl<$Res>
    implements _$ApodsDataCopyWith<$Res> {
  __$ApodsDataCopyWithImpl(this._self, this._then);

  final _ApodsData _self;
  final $Res Function(_ApodsData) _then;

/// Create a copy of ApodsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apodPages = null,Object? apodPageKeys = null,Object? hasNextPage = null,}) {
  return _then(_ApodsData(
apodPages: null == apodPages ? _self._apodPages : apodPages // ignore: cast_nullable_to_non_nullable
as List<List<Apod>>,apodPageKeys: null == apodPageKeys ? _self._apodPageKeys : apodPageKeys // ignore: cast_nullable_to_non_nullable
as List<ApodsPageKey>,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
