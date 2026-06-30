// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) {
  return _AnnouncementModel.fromJson(json);
}

/// @nodoc
mixin _$AnnouncementModel {
  String get id => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String? get authorAvatar => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;

  /// Serializes this AnnouncementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnouncementModelCopyWith<AnnouncementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementModelCopyWith<$Res> {
  factory $AnnouncementModelCopyWith(
          AnnouncementModel value, $Res Function(AnnouncementModel) then) =
      _$AnnouncementModelCopyWithImpl<$Res, AnnouncementModel>;
  @useResult
  $Res call(
      {String id,
      String projectId,
      String title,
      String content,
      String authorName,
      String? authorAvatar,
      DateTime createdAt,
      bool isImportant});
}

/// @nodoc
class _$AnnouncementModelCopyWithImpl<$Res, $Val extends AnnouncementModel>
    implements $AnnouncementModelCopyWith<$Res> {
  _$AnnouncementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? createdAt = null,
    Object? isImportant = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: freezed == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnnouncementModelImplCopyWith<$Res>
    implements $AnnouncementModelCopyWith<$Res> {
  factory _$$AnnouncementModelImplCopyWith(_$AnnouncementModelImpl value,
          $Res Function(_$AnnouncementModelImpl) then) =
      __$$AnnouncementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String projectId,
      String title,
      String content,
      String authorName,
      String? authorAvatar,
      DateTime createdAt,
      bool isImportant});
}

/// @nodoc
class __$$AnnouncementModelImplCopyWithImpl<$Res>
    extends _$AnnouncementModelCopyWithImpl<$Res, _$AnnouncementModelImpl>
    implements _$$AnnouncementModelImplCopyWith<$Res> {
  __$$AnnouncementModelImplCopyWithImpl(_$AnnouncementModelImpl _value,
      $Res Function(_$AnnouncementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? createdAt = null,
    Object? isImportant = null,
  }) {
    return _then(_$AnnouncementModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: freezed == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isImportant: null == isImportant
          ? _value.isImportant
          : isImportant // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnouncementModelImpl implements _AnnouncementModel {
  const _$AnnouncementModelImpl(
      {required this.id,
      required this.projectId,
      required this.title,
      required this.content,
      required this.authorName,
      this.authorAvatar,
      required this.createdAt,
      this.isImportant = false});

  factory _$AnnouncementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnouncementModelImplFromJson(json);

  @override
  final String id;
  @override
  final String projectId;
  @override
  final String title;
  @override
  final String content;
  @override
  final String authorName;
  @override
  final String? authorAvatar;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isImportant;

  @override
  String toString() {
    return 'AnnouncementModel(id: $id, projectId: $projectId, title: $title, content: $content, authorName: $authorName, authorAvatar: $authorAvatar, createdAt: $createdAt, isImportant: $isImportant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnouncementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorAvatar, authorAvatar) ||
                other.authorAvatar == authorAvatar) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, title, content,
      authorName, authorAvatar, createdAt, isImportant);

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnouncementModelImplCopyWith<_$AnnouncementModelImpl> get copyWith =>
      __$$AnnouncementModelImplCopyWithImpl<_$AnnouncementModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnouncementModelImplToJson(
      this,
    );
  }
}

abstract class _AnnouncementModel implements AnnouncementModel {
  const factory _AnnouncementModel(
      {required final String id,
      required final String projectId,
      required final String title,
      required final String content,
      required final String authorName,
      final String? authorAvatar,
      required final DateTime createdAt,
      final bool isImportant}) = _$AnnouncementModelImpl;

  factory _AnnouncementModel.fromJson(Map<String, dynamic> json) =
      _$AnnouncementModelImpl.fromJson;

  @override
  String get id;
  @override
  String get projectId;
  @override
  String get title;
  @override
  String get content;
  @override
  String get authorName;
  @override
  String? get authorAvatar;
  @override
  DateTime get createdAt;
  @override
  bool get isImportant;

  /// Create a copy of AnnouncementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnouncementModelImplCopyWith<_$AnnouncementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
