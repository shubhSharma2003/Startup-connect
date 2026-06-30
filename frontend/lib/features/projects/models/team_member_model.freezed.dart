// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamMemberModel _$TeamMemberModelFromJson(Map<String, dynamic> json) {
  return _TeamMemberModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this TeamMemberModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberModelCopyWith<TeamMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberModelCopyWith<$Res> {
  factory $TeamMemberModelCopyWith(
          TeamMemberModel value, $Res Function(TeamMemberModel) then) =
      _$TeamMemberModelCopyWithImpl<$Res, TeamMemberModel>;
  @useResult
  $Res call({String id, String name, String role, String? avatarUrl});
}

/// @nodoc
class _$TeamMemberModelCopyWithImpl<$Res, $Val extends TeamMemberModel>
    implements $TeamMemberModelCopyWith<$Res> {
  _$TeamMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? role = null,
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
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMemberModelImplCopyWith<$Res>
    implements $TeamMemberModelCopyWith<$Res> {
  factory _$$TeamMemberModelImplCopyWith(_$TeamMemberModelImpl value,
          $Res Function(_$TeamMemberModelImpl) then) =
      __$$TeamMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String role, String? avatarUrl});
}

/// @nodoc
class __$$TeamMemberModelImplCopyWithImpl<$Res>
    extends _$TeamMemberModelCopyWithImpl<$Res, _$TeamMemberModelImpl>
    implements _$$TeamMemberModelImplCopyWith<$Res> {
  __$$TeamMemberModelImplCopyWithImpl(
      _$TeamMemberModelImpl _value, $Res Function(_$TeamMemberModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? role = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$TeamMemberModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberModelImpl implements _TeamMemberModel {
  const _$TeamMemberModelImpl(
      {required this.id,
      required this.name,
      required this.role,
      this.avatarUrl});

  factory _$TeamMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String role;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'TeamMemberModel(id: $id, name: $name, role: $role, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, role, avatarUrl);

  /// Create a copy of TeamMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberModelImplCopyWith<_$TeamMemberModelImpl> get copyWith =>
      __$$TeamMemberModelImplCopyWithImpl<_$TeamMemberModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMemberModel implements TeamMemberModel {
  const factory _TeamMemberModel(
      {required final String id,
      required final String name,
      required final String role,
      final String? avatarUrl}) = _$TeamMemberModelImpl;

  factory _TeamMemberModel.fromJson(Map<String, dynamic> json) =
      _$TeamMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get role;
  @override
  String? get avatarUrl;

  /// Create a copy of TeamMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberModelImplCopyWith<_$TeamMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
