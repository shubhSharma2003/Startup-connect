// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectFormModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  int get maxTeamSize => throw _privateConstructorUsedError;
  XFile? get coverImage => throw _privateConstructorUsedError;

  /// Create a copy of ProjectFormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectFormModelCopyWith<ProjectFormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFormModelCopyWith<$Res> {
  factory $ProjectFormModelCopyWith(
          ProjectFormModel value, $Res Function(ProjectFormModel) then) =
      _$ProjectFormModelCopyWithImpl<$Res, ProjectFormModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      List<String> requiredSkills,
      int maxTeamSize,
      XFile? coverImage});
}

/// @nodoc
class _$ProjectFormModelCopyWithImpl<$Res, $Val extends ProjectFormModel>
    implements $ProjectFormModelCopyWith<$Res> {
  _$ProjectFormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectFormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? requiredSkills = null,
    Object? maxTeamSize = null,
    Object? coverImage = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSkills: null == requiredSkills
          ? _value.requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectFormModelImplCopyWith<$Res>
    implements $ProjectFormModelCopyWith<$Res> {
  factory _$$ProjectFormModelImplCopyWith(_$ProjectFormModelImpl value,
          $Res Function(_$ProjectFormModelImpl) then) =
      __$$ProjectFormModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      List<String> requiredSkills,
      int maxTeamSize,
      XFile? coverImage});
}

/// @nodoc
class __$$ProjectFormModelImplCopyWithImpl<$Res>
    extends _$ProjectFormModelCopyWithImpl<$Res, _$ProjectFormModelImpl>
    implements _$$ProjectFormModelImplCopyWith<$Res> {
  __$$ProjectFormModelImplCopyWithImpl(_$ProjectFormModelImpl _value,
      $Res Function(_$ProjectFormModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectFormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? requiredSkills = null,
    Object? maxTeamSize = null,
    Object? coverImage = freezed,
  }) {
    return _then(_$ProjectFormModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSkills: null == requiredSkills
          ? _value._requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxTeamSize: null == maxTeamSize
          ? _value.maxTeamSize
          : maxTeamSize // ignore: cast_nullable_to_non_nullable
              as int,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class _$ProjectFormModelImpl implements _ProjectFormModel {
  const _$ProjectFormModelImpl(
      {this.title = '',
      this.description = '',
      final List<String> requiredSkills = const [],
      this.maxTeamSize = 5,
      this.coverImage})
      : _requiredSkills = requiredSkills;

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
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
  final int maxTeamSize;
  @override
  final XFile? coverImage;

  @override
  String toString() {
    return 'ProjectFormModel(title: $title, description: $description, requiredSkills: $requiredSkills, maxTeamSize: $maxTeamSize, coverImage: $coverImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectFormModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._requiredSkills, _requiredSkills) &&
            (identical(other.maxTeamSize, maxTeamSize) ||
                other.maxTeamSize == maxTeamSize) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      const DeepCollectionEquality().hash(_requiredSkills),
      maxTeamSize,
      coverImage);

  /// Create a copy of ProjectFormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectFormModelImplCopyWith<_$ProjectFormModelImpl> get copyWith =>
      __$$ProjectFormModelImplCopyWithImpl<_$ProjectFormModelImpl>(
          this, _$identity);
}

abstract class _ProjectFormModel implements ProjectFormModel {
  const factory _ProjectFormModel(
      {final String title,
      final String description,
      final List<String> requiredSkills,
      final int maxTeamSize,
      final XFile? coverImage}) = _$ProjectFormModelImpl;

  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get requiredSkills;
  @override
  int get maxTeamSize;
  @override
  XFile? get coverImage;

  /// Create a copy of ProjectFormModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectFormModelImplCopyWith<_$ProjectFormModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
