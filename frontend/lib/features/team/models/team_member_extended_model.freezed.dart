// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member_extended_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamMemberExtendedModel _$TeamMemberExtendedModelFromJson(
    Map<String, dynamic> json) {
  return _TeamMemberExtendedModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMemberExtendedModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  TeamRole get role => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this TeamMemberExtendedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMemberExtendedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberExtendedModelCopyWith<TeamMemberExtendedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberExtendedModelCopyWith<$Res> {
  factory $TeamMemberExtendedModelCopyWith(TeamMemberExtendedModel value,
          $Res Function(TeamMemberExtendedModel) then) =
      _$TeamMemberExtendedModelCopyWithImpl<$Res, TeamMemberExtendedModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String title,
      TeamRole role,
      DateTime joinedAt,
      String? avatarUrl});
}

/// @nodoc
class _$TeamMemberExtendedModelCopyWithImpl<$Res,
        $Val extends TeamMemberExtendedModel>
    implements $TeamMemberExtendedModelCopyWith<$Res> {
  _$TeamMemberExtendedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMemberExtendedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? role = null,
    Object? joinedAt = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamRole,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMemberExtendedModelImplCopyWith<$Res>
    implements $TeamMemberExtendedModelCopyWith<$Res> {
  factory _$$TeamMemberExtendedModelImplCopyWith(
          _$TeamMemberExtendedModelImpl value,
          $Res Function(_$TeamMemberExtendedModelImpl) then) =
      __$$TeamMemberExtendedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String title,
      TeamRole role,
      DateTime joinedAt,
      String? avatarUrl});
}

/// @nodoc
class __$$TeamMemberExtendedModelImplCopyWithImpl<$Res>
    extends _$TeamMemberExtendedModelCopyWithImpl<$Res,
        _$TeamMemberExtendedModelImpl>
    implements _$$TeamMemberExtendedModelImplCopyWith<$Res> {
  __$$TeamMemberExtendedModelImplCopyWithImpl(
      _$TeamMemberExtendedModelImpl _value,
      $Res Function(_$TeamMemberExtendedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamMemberExtendedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? role = null,
    Object? joinedAt = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$TeamMemberExtendedModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamRole,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberExtendedModelImpl implements _TeamMemberExtendedModel {
  const _$TeamMemberExtendedModelImpl(
      {required this.id,
      required this.name,
      required this.title,
      required this.role,
      required this.joinedAt,
      this.avatarUrl});

  factory _$TeamMemberExtendedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberExtendedModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String title;
  @override
  final TeamRole role;
  @override
  final DateTime joinedAt;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'TeamMemberExtendedModel(id: $id, name: $name, title: $title, role: $role, joinedAt: $joinedAt, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberExtendedModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, title, role, joinedAt, avatarUrl);

  /// Create a copy of TeamMemberExtendedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberExtendedModelImplCopyWith<_$TeamMemberExtendedModelImpl>
      get copyWith => __$$TeamMemberExtendedModelImplCopyWithImpl<
          _$TeamMemberExtendedModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberExtendedModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMemberExtendedModel implements TeamMemberExtendedModel {
  const factory _TeamMemberExtendedModel(
      {required final String id,
      required final String name,
      required final String title,
      required final TeamRole role,
      required final DateTime joinedAt,
      final String? avatarUrl}) = _$TeamMemberExtendedModelImpl;

  factory _TeamMemberExtendedModel.fromJson(Map<String, dynamic> json) =
      _$TeamMemberExtendedModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get title;
  @override
  TeamRole get role;
  @override
  DateTime get joinedAt;
  @override
  String? get avatarUrl;

  /// Create a copy of TeamMemberExtendedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberExtendedModelImplCopyWith<_$TeamMemberExtendedModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
