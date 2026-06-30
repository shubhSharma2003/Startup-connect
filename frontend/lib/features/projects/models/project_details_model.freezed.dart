// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectDetailsModel _$ProjectDetailsModelFromJson(Map<String, dynamic> json) {
  return _ProjectDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectDetailsModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get fullDescription => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  List<TeamMemberModel> get teamMembers => throw _privateConstructorUsedError;
  int get maxTeamSize => throw _privateConstructorUsedError;
  ApplicationStatus get applicationStatus => throw _privateConstructorUsedError;

  /// Serializes this ProjectDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectDetailsModelCopyWith<ProjectDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectDetailsModelCopyWith<$Res> {
  factory $ProjectDetailsModelCopyWith(
          ProjectDetailsModel value, $Res Function(ProjectDetailsModel) then) =
      _$ProjectDetailsModelCopyWithImpl<$Res, ProjectDetailsModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String fullDescription,
      String ownerName,
      String ownerId,
      String status,
      DateTime createdAt,
      List<String> requiredSkills,
      List<TeamMemberModel> teamMembers,
      int maxTeamSize,
      ApplicationStatus applicationStatus});
}

/// @nodoc
class _$ProjectDetailsModelCopyWithImpl<$Res, $Val extends ProjectDetailsModel>
    implements $ProjectDetailsModelCopyWith<$Res> {
  _$ProjectDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fullDescription = null,
    Object? ownerName = null,
    Object? ownerId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requiredSkills = null,
    Object? teamMembers = null,
    Object? maxTeamSize = null,
    Object? applicationStatus = null,
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
      fullDescription: null == fullDescription
          ? _value.fullDescription
          : fullDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
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
      teamMembers: null == teamMembers
          ? _value.teamMembers
          : teamMembers // ignore: cast_nullable_to_non_nullable
              as List<TeamMemberModel>,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
      applicationStatus: null == applicationStatus
          ? _value.applicationStatus
          : applicationStatus // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectDetailsModelImplCopyWith<$Res>
    implements $ProjectDetailsModelCopyWith<$Res> {
  factory _$$ProjectDetailsModelImplCopyWith(_$ProjectDetailsModelImpl value,
          $Res Function(_$ProjectDetailsModelImpl) then) =
      __$$ProjectDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String fullDescription,
      String ownerName,
      String ownerId,
      String status,
      DateTime createdAt,
      List<String> requiredSkills,
      List<TeamMemberModel> teamMembers,
      int maxTeamSize,
      ApplicationStatus applicationStatus});
}

/// @nodoc
class __$$ProjectDetailsModelImplCopyWithImpl<$Res>
    extends _$ProjectDetailsModelCopyWithImpl<$Res, _$ProjectDetailsModelImpl>
    implements _$$ProjectDetailsModelImplCopyWith<$Res> {
  __$$ProjectDetailsModelImplCopyWithImpl(_$ProjectDetailsModelImpl _value,
      $Res Function(_$ProjectDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fullDescription = null,
    Object? ownerName = null,
    Object? ownerId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requiredSkills = null,
    Object? teamMembers = null,
    Object? maxTeamSize = null,
    Object? applicationStatus = null,
  }) {
    return _then(_$ProjectDetailsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      fullDescription: null == fullDescription
          ? _value.fullDescription
          : fullDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
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
      teamMembers: null == teamMembers
          ? _value._teamMembers
          : teamMembers // ignore: cast_nullable_to_non_nullable
              as List<TeamMemberModel>,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
      applicationStatus: null == applicationStatus
          ? _value.applicationStatus
          : applicationStatus // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectDetailsModelImpl implements _ProjectDetailsModel {
  const _$ProjectDetailsModelImpl(
      {required this.id,
      required this.title,
      required this.fullDescription,
      required this.ownerName,
      required this.ownerId,
      required this.status,
      required this.createdAt,
      final List<String> requiredSkills = const [],
      final List<TeamMemberModel> teamMembers = const [],
      this.maxTeamSize = 0,
      this.applicationStatus = ApplicationStatus.NONE})
      : _requiredSkills = requiredSkills,
        _teamMembers = teamMembers;

  factory _$ProjectDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectDetailsModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String fullDescription;
  @override
  final String ownerName;
  @override
  final String ownerId;
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

  final List<TeamMemberModel> _teamMembers;
  @override
  @JsonKey()
  List<TeamMemberModel> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  @override
  @JsonKey()
  final int maxTeamSize;
  @override
  @JsonKey()
  final ApplicationStatus applicationStatus;

  @override
  String toString() {
    return 'ProjectDetailsModel(id: $id, title: $title, fullDescription: $fullDescription, ownerName: $ownerName, ownerId: $ownerId, status: $status, createdAt: $createdAt, requiredSkills: $requiredSkills, teamMembers: $teamMembers, maxTeamSize: $maxTeamSize, applicationStatus: $applicationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fullDescription, fullDescription) ||
                other.fullDescription == fullDescription) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._requiredSkills, _requiredSkills) &&
            const DeepCollectionEquality()
                .equals(other._teamMembers, _teamMembers) &&
            (identical(other.maxTeamSize, maxTeamSize) ||
                other.maxTeamSize == maxTeamSize) &&
            (identical(other.applicationStatus, applicationStatus) ||
                other.applicationStatus == applicationStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      fullDescription,
      ownerName,
      ownerId,
      status,
      createdAt,
      const DeepCollectionEquality().hash(_requiredSkills),
      const DeepCollectionEquality().hash(_teamMembers),
      maxTeamSize,
      applicationStatus);

  /// Create a copy of ProjectDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectDetailsModelImplCopyWith<_$ProjectDetailsModelImpl> get copyWith =>
      __$$ProjectDetailsModelImplCopyWithImpl<_$ProjectDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _ProjectDetailsModel implements ProjectDetailsModel {
  const factory _ProjectDetailsModel(
      {required final String id,
      required final String title,
      required final String fullDescription,
      required final String ownerName,
      required final String ownerId,
      required final String status,
      required final DateTime createdAt,
      final List<String> requiredSkills,
      final List<TeamMemberModel> teamMembers,
      final int maxTeamSize,
      final ApplicationStatus applicationStatus}) = _$ProjectDetailsModelImpl;

  factory _ProjectDetailsModel.fromJson(Map<String, dynamic> json) =
      _$ProjectDetailsModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get fullDescription;
  @override
  String get ownerName;
  @override
  String get ownerId;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  List<String> get requiredSkills;
  @override
  List<TeamMemberModel> get teamMembers;
  @override
  int get maxTeamSize;
  @override
  ApplicationStatus get applicationStatus;

  /// Create a copy of ProjectDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectDetailsModelImplCopyWith<_$ProjectDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
