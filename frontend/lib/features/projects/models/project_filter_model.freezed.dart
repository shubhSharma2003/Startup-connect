// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectFilterModel {
  String get searchQuery => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Create a copy of ProjectFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectFilterModelCopyWith<ProjectFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectFilterModelCopyWith<$Res> {
  factory $ProjectFilterModelCopyWith(
          ProjectFilterModel value, $Res Function(ProjectFilterModel) then) =
      _$ProjectFilterModelCopyWithImpl<$Res, ProjectFilterModel>;
  @useResult
  $Res call({String searchQuery, String? status});
}

/// @nodoc
class _$ProjectFilterModelCopyWithImpl<$Res, $Val extends ProjectFilterModel>
    implements $ProjectFilterModelCopyWith<$Res> {
  _$ProjectFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectFilterModelImplCopyWith<$Res>
    implements $ProjectFilterModelCopyWith<$Res> {
  factory _$$ProjectFilterModelImplCopyWith(_$ProjectFilterModelImpl value,
          $Res Function(_$ProjectFilterModelImpl) then) =
      __$$ProjectFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String searchQuery, String? status});
}

/// @nodoc
class __$$ProjectFilterModelImplCopyWithImpl<$Res>
    extends _$ProjectFilterModelCopyWithImpl<$Res, _$ProjectFilterModelImpl>
    implements _$$ProjectFilterModelImplCopyWith<$Res> {
  __$$ProjectFilterModelImplCopyWithImpl(_$ProjectFilterModelImpl _value,
      $Res Function(_$ProjectFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? status = freezed,
  }) {
    return _then(_$ProjectFilterModelImpl(
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProjectFilterModelImpl implements _ProjectFilterModel {
  const _$ProjectFilterModelImpl({this.searchQuery = '', this.status});

  @override
  @JsonKey()
  final String searchQuery;
  @override
  final String? status;

  @override
  String toString() {
    return 'ProjectFilterModel(searchQuery: $searchQuery, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectFilterModelImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery, status);

  /// Create a copy of ProjectFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectFilterModelImplCopyWith<_$ProjectFilterModelImpl> get copyWith =>
      __$$ProjectFilterModelImplCopyWithImpl<_$ProjectFilterModelImpl>(
          this, _$identity);
}

abstract class _ProjectFilterModel implements ProjectFilterModel {
  const factory _ProjectFilterModel(
      {final String searchQuery,
      final String? status}) = _$ProjectFilterModelImpl;

  @override
  String get searchQuery;
  @override
  String? get status;

  /// Create a copy of ProjectFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectFilterModelImplCopyWith<_$ProjectFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
