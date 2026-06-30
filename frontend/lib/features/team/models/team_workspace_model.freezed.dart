// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_workspace_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamWorkspaceModel _$TeamWorkspaceModelFromJson(Map<String, dynamic> json) {
  return _TeamWorkspaceModel.fromJson(json);
}

/// @nodoc
mixin _$TeamWorkspaceModel {
  String get projectId => throw _privateConstructorUsedError;
  String get projectTitle => throw _privateConstructorUsedError;
  int get activeMembers => throw _privateConstructorUsedError;
  int get pendingTasks => throw _privateConstructorUsedError;
  int get upcomingDeadlines => throw _privateConstructorUsedError;
  int get completedMilestones => throw _privateConstructorUsedError;
  List<TeamMemberExtendedModel> get members =>
      throw _privateConstructorUsedError;

  /// Serializes this TeamWorkspaceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamWorkspaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamWorkspaceModelCopyWith<TeamWorkspaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamWorkspaceModelCopyWith<$Res> {
  factory $TeamWorkspaceModelCopyWith(
          TeamWorkspaceModel value, $Res Function(TeamWorkspaceModel) then) =
      _$TeamWorkspaceModelCopyWithImpl<$Res, TeamWorkspaceModel>;
  @useResult
  $Res call(
      {String projectId,
      String projectTitle,
      int activeMembers,
      int pendingTasks,
      int upcomingDeadlines,
      int completedMilestones,
      List<TeamMemberExtendedModel> members});
}

/// @nodoc
class _$TeamWorkspaceModelCopyWithImpl<$Res, $Val extends TeamWorkspaceModel>
    implements $TeamWorkspaceModelCopyWith<$Res> {
  _$TeamWorkspaceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamWorkspaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectTitle = null,
    Object? activeMembers = null,
    Object? pendingTasks = null,
    Object? upcomingDeadlines = null,
    Object? completedMilestones = null,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      projectTitle: null == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String,
      activeMembers: null == activeMembers
          ? _value.activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as int,
      pendingTasks: null == pendingTasks
          ? _value.pendingTasks
          : pendingTasks // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingDeadlines: null == upcomingDeadlines
          ? _value.upcomingDeadlines
          : upcomingDeadlines // ignore: cast_nullable_to_non_nullable
              as int,
      completedMilestones: null == completedMilestones
          ? _value.completedMilestones
          : completedMilestones // ignore: cast_nullable_to_non_nullable
              as int,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TeamMemberExtendedModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamWorkspaceModelImplCopyWith<$Res>
    implements $TeamWorkspaceModelCopyWith<$Res> {
  factory _$$TeamWorkspaceModelImplCopyWith(_$TeamWorkspaceModelImpl value,
          $Res Function(_$TeamWorkspaceModelImpl) then) =
      __$$TeamWorkspaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectId,
      String projectTitle,
      int activeMembers,
      int pendingTasks,
      int upcomingDeadlines,
      int completedMilestones,
      List<TeamMemberExtendedModel> members});
}

/// @nodoc
class __$$TeamWorkspaceModelImplCopyWithImpl<$Res>
    extends _$TeamWorkspaceModelCopyWithImpl<$Res, _$TeamWorkspaceModelImpl>
    implements _$$TeamWorkspaceModelImplCopyWith<$Res> {
  __$$TeamWorkspaceModelImplCopyWithImpl(_$TeamWorkspaceModelImpl _value,
      $Res Function(_$TeamWorkspaceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamWorkspaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectTitle = null,
    Object? activeMembers = null,
    Object? pendingTasks = null,
    Object? upcomingDeadlines = null,
    Object? completedMilestones = null,
    Object? members = null,
  }) {
    return _then(_$TeamWorkspaceModelImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      projectTitle: null == projectTitle
          ? _value.projectTitle
          : projectTitle // ignore: cast_nullable_to_non_nullable
              as String,
      activeMembers: null == activeMembers
          ? _value.activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as int,
      pendingTasks: null == pendingTasks
          ? _value.pendingTasks
          : pendingTasks // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingDeadlines: null == upcomingDeadlines
          ? _value.upcomingDeadlines
          : upcomingDeadlines // ignore: cast_nullable_to_non_nullable
              as int,
      completedMilestones: null == completedMilestones
          ? _value.completedMilestones
          : completedMilestones // ignore: cast_nullable_to_non_nullable
              as int,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TeamMemberExtendedModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamWorkspaceModelImpl implements _TeamWorkspaceModel {
  const _$TeamWorkspaceModelImpl(
      {required this.projectId,
      required this.projectTitle,
      this.activeMembers = 0,
      this.pendingTasks = 0,
      this.upcomingDeadlines = 0,
      this.completedMilestones = 0,
      final List<TeamMemberExtendedModel> members = const []})
      : _members = members;

  factory _$TeamWorkspaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamWorkspaceModelImplFromJson(json);

  @override
  final String projectId;
  @override
  final String projectTitle;
  @override
  @JsonKey()
  final int activeMembers;
  @override
  @JsonKey()
  final int pendingTasks;
  @override
  @JsonKey()
  final int upcomingDeadlines;
  @override
  @JsonKey()
  final int completedMilestones;
  final List<TeamMemberExtendedModel> _members;
  @override
  @JsonKey()
  List<TeamMemberExtendedModel> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'TeamWorkspaceModel(projectId: $projectId, projectTitle: $projectTitle, activeMembers: $activeMembers, pendingTasks: $pendingTasks, upcomingDeadlines: $upcomingDeadlines, completedMilestones: $completedMilestones, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamWorkspaceModelImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectTitle, projectTitle) ||
                other.projectTitle == projectTitle) &&
            (identical(other.activeMembers, activeMembers) ||
                other.activeMembers == activeMembers) &&
            (identical(other.pendingTasks, pendingTasks) ||
                other.pendingTasks == pendingTasks) &&
            (identical(other.upcomingDeadlines, upcomingDeadlines) ||
                other.upcomingDeadlines == upcomingDeadlines) &&
            (identical(other.completedMilestones, completedMilestones) ||
                other.completedMilestones == completedMilestones) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectId,
      projectTitle,
      activeMembers,
      pendingTasks,
      upcomingDeadlines,
      completedMilestones,
      const DeepCollectionEquality().hash(_members));

  /// Create a copy of TeamWorkspaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamWorkspaceModelImplCopyWith<_$TeamWorkspaceModelImpl> get copyWith =>
      __$$TeamWorkspaceModelImplCopyWithImpl<_$TeamWorkspaceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamWorkspaceModelImplToJson(
      this,
    );
  }
}

abstract class _TeamWorkspaceModel implements TeamWorkspaceModel {
  const factory _TeamWorkspaceModel(
      {required final String projectId,
      required final String projectTitle,
      final int activeMembers,
      final int pendingTasks,
      final int upcomingDeadlines,
      final int completedMilestones,
      final List<TeamMemberExtendedModel> members}) = _$TeamWorkspaceModelImpl;

  factory _TeamWorkspaceModel.fromJson(Map<String, dynamic> json) =
      _$TeamWorkspaceModelImpl.fromJson;

  @override
  String get projectId;
  @override
  String get projectTitle;
  @override
  int get activeMembers;
  @override
  int get pendingTasks;
  @override
  int get upcomingDeadlines;
  @override
  int get completedMilestones;
  @override
  List<TeamMemberExtendedModel> get members;

  /// Create a copy of TeamWorkspaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamWorkspaceModelImplCopyWith<_$TeamWorkspaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
