// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReelStateModel {
  File? get videoFile => throw _privateConstructorUsedError;
  List<CameraDescription> get cameraList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReelStateModelCopyWith<ReelStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReelStateModelCopyWith<$Res> {
  factory $ReelStateModelCopyWith(
          ReelStateModel value, $Res Function(ReelStateModel) then) =
      _$ReelStateModelCopyWithImpl<$Res, ReelStateModel>;
  @useResult
  $Res call({File? videoFile, List<CameraDescription> cameraList});
}

/// @nodoc
class _$ReelStateModelCopyWithImpl<$Res, $Val extends ReelStateModel>
    implements $ReelStateModelCopyWith<$Res> {
  _$ReelStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoFile = freezed,
    Object? cameraList = null,
  }) {
    return _then(_value.copyWith(
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as File?,
      cameraList: null == cameraList
          ? _value.cameraList
          : cameraList // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReelStateModelCopyWith<$Res>
    implements $ReelStateModelCopyWith<$Res> {
  factory _$$_ReelStateModelCopyWith(
          _$_ReelStateModel value, $Res Function(_$_ReelStateModel) then) =
      __$$_ReelStateModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? videoFile, List<CameraDescription> cameraList});
}

/// @nodoc
class __$$_ReelStateModelCopyWithImpl<$Res>
    extends _$ReelStateModelCopyWithImpl<$Res, _$_ReelStateModel>
    implements _$$_ReelStateModelCopyWith<$Res> {
  __$$_ReelStateModelCopyWithImpl(
      _$_ReelStateModel _value, $Res Function(_$_ReelStateModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoFile = freezed,
    Object? cameraList = null,
  }) {
    return _then(_$_ReelStateModel(
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as File?,
      cameraList: null == cameraList
          ? _value._cameraList
          : cameraList // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
    ));
  }
}

/// @nodoc

class _$_ReelStateModel implements _ReelStateModel {
  _$_ReelStateModel(
      {this.videoFile, final List<CameraDescription> cameraList = const []})
      : _cameraList = cameraList;

  @override
  final File? videoFile;
  final List<CameraDescription> _cameraList;
  @override
  @JsonKey()
  List<CameraDescription> get cameraList {
    if (_cameraList is EqualUnmodifiableListView) return _cameraList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cameraList);
  }

  @override
  String toString() {
    return 'ReelStateModel(videoFile: $videoFile, cameraList: $cameraList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReelStateModel &&
            (identical(other.videoFile, videoFile) ||
                other.videoFile == videoFile) &&
            const DeepCollectionEquality()
                .equals(other._cameraList, _cameraList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, videoFile, const DeepCollectionEquality().hash(_cameraList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReelStateModelCopyWith<_$_ReelStateModel> get copyWith =>
      __$$_ReelStateModelCopyWithImpl<_$_ReelStateModel>(this, _$identity);
}

abstract class _ReelStateModel implements ReelStateModel {
  factory _ReelStateModel(
      {final File? videoFile,
      final List<CameraDescription> cameraList}) = _$_ReelStateModel;

  @override
  File? get videoFile;
  @override
  List<CameraDescription> get cameraList;
  @override
  @JsonKey(ignore: true)
  _$$_ReelStateModelCopyWith<_$_ReelStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
