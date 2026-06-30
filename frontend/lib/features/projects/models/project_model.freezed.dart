// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  int get teamSize => throw _privateConstructorUsedError;
  int get maxTeamSize => throw _privateConstructorUsedError;

  /// Serializes this ProjectModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
          ProjectModel value, $Res Function(ProjectModel) then) =
      _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String shortDescription,
      String ownerName,
      String status,
      DateTime createdAt,
      List<String> requiredSkills,
      int teamSize,
      int maxTeamSize});
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? ownerName = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requiredSkills = null,
    Object? teamSize = null,
    Object? maxTeamSize = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredSkills: null == requiredSkills
          ? _value.requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teamSize: null == teamSize
          ? _value.teamSize
          : teamSize // ignore: cast_nullable_to_non_nullable
              as int,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
          _$ProjectModelImpl value, $Res Function(_$ProjectModelImpl) then) =
      __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String shortDescription,
      String ownerName,
      String status,
      DateTime createdAt,
      List<String> requiredSkills,
      int teamSize,
      int maxTeamSize});
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
      _$ProjectModelImpl _value, $Res Function(_$ProjectModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? ownerName = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requiredSkills = null,
    Object? teamSize = null,
    Object? maxTeamSize = null,
  }) {
    return _then(_$ProjectModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredSkills: null == requiredSkills
          ? _value._requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teamSize: null == teamSize
          ? _value.teamSize
          : teamSize // ignore: cast_nullable_to_non_nullable
              as int,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModelImpl implements _ProjectModel {
  const _$ProjectModelImpl(
      {required this.id,
      required this.title,
      required this.shortDescription,
      required this.ownerName,
      required this.status,
      required this.createdAt,
      final List<String> requiredSkills = const [],
      this.teamSize = 0,
      this.maxTeamSize = 0})
      : _requiredSkills = requiredSkills;

  factory _$ProjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String shortDescription;
  @override
  final String ownerName;
  @override
  final String status;
  @override
  final DateTime createdAt;
  final List<String> _requiredSkills;
  @override
  @JsonKey()
  List<String> get requiredSkills {
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSkills);
  }

  @override
  @JsonKey()
  final int teamSize;
  @override
  @JsonKey()
  final int maxTeamSize;

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, shortDescription: $shortDescription, ownerName: $ownerName, status: $status, createdAt: $createdAt, requiredSkills: $requiredSkills, teamSize: $teamSize, maxTeamSize: $maxTeamSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._requiredSkills, _requiredSkills) &&
            (identical(other.teamSize, teamSize) ||
                other.teamSize == teamSize) &&
            (identical(other.maxTeamSize, maxTeamSize) ||
                other.maxTeamSize == maxTeamSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      shortDescription,
      ownerName,
      status,
      createdAt,
      const DeepCollectionEquality().hash(_requiredSkills),
      teamSize,
      maxTeamSize);

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModelImplToJson(
      this,
    );
  }
}

abstract class _ProjectModel implements ProjectModel {
  const factory _ProjectModel(
      {required final String id,
      required final String title,
      required final String shortDescription,
      required final String ownerName,
      required final String status,
      required final DateTime createdAt,
      final List<String> requiredSkills,
      final int teamSize,
      final int maxTeamSize}) = _$ProjectModelImpl;

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$ProjectModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get shortDescription;
  @override
  String get ownerName;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  List<String> get requiredSkills;
  @override
  int get teamSize;
  @override
  int get maxTeamSize;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
