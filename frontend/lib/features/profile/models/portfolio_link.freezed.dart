// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PortfolioLink _$PortfolioLinkFromJson(Map<String, dynamic> json) {
  return _PortfolioLink.fromJson(json);
}

/// @nodoc
mixin _$PortfolioLink {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this PortfolioLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioLinkCopyWith<PortfolioLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioLinkCopyWith<$Res> {
  factory $PortfolioLinkCopyWith(
          PortfolioLink value, $Res Function(PortfolioLink) then) =
      _$PortfolioLinkCopyWithImpl<$Res, PortfolioLink>;
  @useResult
  $Res call({int id, String title, String url});
}

/// @nodoc
class _$PortfolioLinkCopyWithImpl<$Res, $Val extends PortfolioLink>
    implements $PortfolioLinkCopyWith<$Res> {
  _$PortfolioLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioLinkImplCopyWith<$Res>
    implements $PortfolioLinkCopyWith<$Res> {
  factory _$$PortfolioLinkImplCopyWith(
          _$PortfolioLinkImpl value, $Res Function(_$PortfolioLinkImpl) then) =
      __$$PortfolioLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, String url});
}

/// @nodoc
class __$$PortfolioLinkImplCopyWithImpl<$Res>
    extends _$PortfolioLinkCopyWithImpl<$Res, _$PortfolioLinkImpl>
    implements _$$PortfolioLinkImplCopyWith<$Res> {
  __$$PortfolioLinkImplCopyWithImpl(
      _$PortfolioLinkImpl _value, $Res Function(_$PortfolioLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$PortfolioLinkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioLinkImpl implements _PortfolioLink {
  const _$PortfolioLinkImpl(
      {required this.id, required this.title, required this.url});

  factory _$PortfolioLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioLinkImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String url;

  @override
  String toString() {
    return 'PortfolioLink(id: $id, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioLinkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url);

  /// Create a copy of PortfolioLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioLinkImplCopyWith<_$PortfolioLinkImpl> get copyWith =>
      __$$PortfolioLinkImplCopyWithImpl<_$PortfolioLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioLinkImplToJson(
      this,
    );
  }
}

abstract class _PortfolioLink implements PortfolioLink {
  const factory _PortfolioLink(
      {required final int id,
      required final String title,
      required final String url}) = _$PortfolioLinkImpl;

  factory _PortfolioLink.fromJson(Map<String, dynamic> json) =
      _$PortfolioLinkImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get url;

  /// Create a copy of PortfolioLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioLinkImplCopyWith<_$PortfolioLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
