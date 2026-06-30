// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  int get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get resumeUrl => throw _privateConstructorUsedError;
  List<SkillModel> get skills => throw _privateConstructorUsedError;
  List<PortfolioLink> get portfolioLinks => throw _privateConstructorUsedError;
  int get projectsCount => throw _privateConstructorUsedError;
  int get teamsCount => throw _privateConstructorUsedError;
  int get connectionsCount => throw _privateConstructorUsedError;

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {int id,
      String firstName,
      String lastName,
      String email,
      String role,
      String? headline,
      String? bio,
      String? avatarUrl,
      String? resumeUrl,
      List<SkillModel> skills,
      List<PortfolioLink> portfolioLinks,
      int projectsCount,
      int teamsCount,
      int connectionsCount});
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? role = null,
    Object? headline = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? resumeUrl = freezed,
    Object? skills = null,
    Object? portfolioLinks = null,
    Object? projectsCount = null,
    Object? teamsCount = null,
    Object? connectionsCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      resumeUrl: freezed == resumeUrl
          ? _value.resumeUrl
          : resumeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>,
      portfolioLinks: null == portfolioLinks
          ? _value.portfolioLinks
          : portfolioLinks // ignore: cast_nullable_to_non_nullable
              as List<PortfolioLink>,
      projectsCount: null == projectsCount
          ? _value.projectsCount
          : projectsCount // ignore: cast_nullable_to_non_nullable
              as int,
      teamsCount: null == teamsCount
          ? _value.teamsCount
          : teamsCount // ignore: cast_nullable_to_non_nullable
              as int,
      connectionsCount: null == connectionsCount
          ? _value.connectionsCount
          : connectionsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String firstName,
      String lastName,
      String email,
      String role,
      String? headline,
      String? bio,
      String? avatarUrl,
      String? resumeUrl,
      List<SkillModel> skills,
      List<PortfolioLink> portfolioLinks,
      int projectsCount,
      int teamsCount,
      int connectionsCount});
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? role = null,
    Object? headline = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? resumeUrl = freezed,
    Object? skills = null,
    Object? portfolioLinks = null,
    Object? projectsCount = null,
    Object? teamsCount = null,
    Object? connectionsCount = null,
  }) {
    return _then(_$ProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      resumeUrl: freezed == resumeUrl
          ? _value.resumeUrl
          : resumeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<SkillModel>,
      portfolioLinks: null == portfolioLinks
          ? _value._portfolioLinks
          : portfolioLinks // ignore: cast_nullable_to_non_nullable
              as List<PortfolioLink>,
      projectsCount: null == projectsCount
          ? _value.projectsCount
          : projectsCount // ignore: cast_nullable_to_non_nullable
              as int,
      teamsCount: null == teamsCount
          ? _value.teamsCount
          : teamsCount // ignore: cast_nullable_to_non_nullable
              as int,
      connectionsCount: null == connectionsCount
          ? _value.connectionsCount
          : connectionsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role,
      this.headline,
      this.bio,
      this.avatarUrl,
      this.resumeUrl,
      final List<SkillModel> skills = const [],
      final List<PortfolioLink> portfolioLinks = const [],
      this.projectsCount = 0,
      this.teamsCount = 0,
      this.connectionsCount = 0})
      : _skills = skills,
        _portfolioLinks = portfolioLinks;

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final int id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String role;
  @override
  final String? headline;
  @override
  final String? bio;
  @override
  final String? avatarUrl;
  @override
  final String? resumeUrl;
  final List<SkillModel> _skills;
  @override
  @JsonKey()
  List<SkillModel> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<PortfolioLink> _portfolioLinks;
  @override
  @JsonKey()
  List<PortfolioLink> get portfolioLinks {
    if (_portfolioLinks is EqualUnmodifiableListView) return _portfolioLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_portfolioLinks);
  }

  @override
  @JsonKey()
  final int projectsCount;
  @override
  @JsonKey()
  final int teamsCount;
  @override
  @JsonKey()
  final int connectionsCount;

  @override
  String toString() {
    return 'ProfileModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, role: $role, headline: $headline, bio: $bio, avatarUrl: $avatarUrl, resumeUrl: $resumeUrl, skills: $skills, portfolioLinks: $portfolioLinks, projectsCount: $projectsCount, teamsCount: $teamsCount, connectionsCount: $connectionsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.resumeUrl, resumeUrl) ||
                other.resumeUrl == resumeUrl) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._portfolioLinks, _portfolioLinks) &&
            (identical(other.projectsCount, projectsCount) ||
                other.projectsCount == projectsCount) &&
            (identical(other.teamsCount, teamsCount) ||
                other.teamsCount == teamsCount) &&
            (identical(other.connectionsCount, connectionsCount) ||
                other.connectionsCount == connectionsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      email,
      role,
      headline,
      bio,
      avatarUrl,
      resumeUrl,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_portfolioLinks),
      projectsCount,
      teamsCount,
      connectionsCount);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel(
      {required final int id,
      required final String firstName,
      required final String lastName,
      required final String email,
      required final String role,
      final String? headline,
      final String? bio,
      final String? avatarUrl,
      final String? resumeUrl,
      final List<SkillModel> skills,
      final List<PortfolioLink> portfolioLinks,
      final int projectsCount,
      final int teamsCount,
      final int connectionsCount}) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  int get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get role;
  @override
  String? get headline;
  @override
  String? get bio;
  @override
  String? get avatarUrl;
  @override
  String? get resumeUrl;
  @override
  List<SkillModel> get skills;
  @override
  List<PortfolioLink> get portfolioLinks;
  @override
  int get projectsCount;
  @override
  int get teamsCount;
  @override
  int get connectionsCount;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
