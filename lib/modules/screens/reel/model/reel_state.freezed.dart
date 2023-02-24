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
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCameraControllerInitialsed => throw _privateConstructorUsedError;
  bool get isRecording => throw _privateConstructorUsedError;
  int get cameraPosition => throw _privateConstructorUsedError;

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
  $Res call(
      {File? videoFile,
      bool isLoading,
      bool isCameraControllerInitialsed,
      bool isRecording,
      int cameraPosition});
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
    Object? isLoading = null,
    Object? isCameraControllerInitialsed = null,
    Object? isRecording = null,
    Object? cameraPosition = null,
  }) {
    return _then(_value.copyWith(
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCameraControllerInitialsed: null == isCameraControllerInitialsed
          ? _value.isCameraControllerInitialsed
          : isCameraControllerInitialsed // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      cameraPosition: null == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call(
      {File? videoFile,
      bool isLoading,
      bool isCameraControllerInitialsed,
      bool isRecording,
      int cameraPosition});
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
    Object? isLoading = null,
    Object? isCameraControllerInitialsed = null,
    Object? isRecording = null,
    Object? cameraPosition = null,
  }) {
    return _then(_$_ReelStateModel(
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCameraControllerInitialsed: null == isCameraControllerInitialsed
          ? _value.isCameraControllerInitialsed
          : isCameraControllerInitialsed // ignore: cast_nullable_to_non_nullable
              as bool,
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      cameraPosition: null == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ReelStateModel implements _ReelStateModel {
  _$_ReelStateModel(
      {this.videoFile,
      this.isLoading = false,
      this.isCameraControllerInitialsed = false,
      this.isRecording = false,
      this.cameraPosition = 0});

  @override
  final File? videoFile;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCameraControllerInitialsed;
  @override
  @JsonKey()
  final bool isRecording;
  @override
  @JsonKey()
  final int cameraPosition;

  @override
  String toString() {
    return 'ReelStateModel(videoFile: $videoFile, isLoading: $isLoading, isCameraControllerInitialsed: $isCameraControllerInitialsed, isRecording: $isRecording, cameraPosition: $cameraPosition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReelStateModel &&
            (identical(other.videoFile, videoFile) ||
                other.videoFile == videoFile) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCameraControllerInitialsed,
                    isCameraControllerInitialsed) ||
                other.isCameraControllerInitialsed ==
                    isCameraControllerInitialsed) &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording) &&
            (identical(other.cameraPosition, cameraPosition) ||
                other.cameraPosition == cameraPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoFile, isLoading,
      isCameraControllerInitialsed, isRecording, cameraPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReelStateModelCopyWith<_$_ReelStateModel> get copyWith =>
      __$$_ReelStateModelCopyWithImpl<_$_ReelStateModel>(this, _$identity);
}

abstract class _ReelStateModel implements ReelStateModel {
  factory _ReelStateModel(
      {final File? videoFile,
      final bool isLoading,
      final bool isCameraControllerInitialsed,
      final bool isRecording,
      final int cameraPosition}) = _$_ReelStateModel;

  @override
  File? get videoFile;
  @override
  bool get isLoading;
  @override
  bool get isCameraControllerInitialsed;
  @override
  bool get isRecording;
  @override
  int get cameraPosition;
  @override
  @JsonKey(ignore: true)
  _$$_ReelStateModelCopyWith<_$_ReelStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
