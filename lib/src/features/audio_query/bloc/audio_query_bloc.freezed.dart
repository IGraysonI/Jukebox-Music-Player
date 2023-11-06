// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_query_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioQueryState {
  List<SongInfo> get songs => throw _privateConstructorUsedError;
  List<AlbumInfo> get albums => throw _privateConstructorUsedError;
  List<ArtistInfo> get artists => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioQueryStateCopyWith<AudioQueryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioQueryStateCopyWith<$Res> {
  factory $AudioQueryStateCopyWith(
          AudioQueryState value, $Res Function(AudioQueryState) then) =
      _$AudioQueryStateCopyWithImpl<$Res, AudioQueryState>;
  @useResult
  $Res call(
      {List<SongInfo> songs,
      List<AlbumInfo> albums,
      List<ArtistInfo> artists,
      bool isProcessing,
      Object? error,
      StackTrace? stackTrace});
}

/// @nodoc
class _$AudioQueryStateCopyWithImpl<$Res, $Val extends AudioQueryState>
    implements $AudioQueryStateCopyWith<$Res> {
  _$AudioQueryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? albums = null,
    Object? artists = null,
    Object? isProcessing = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<SongInfo>,
      albums: null == albums
          ? _value.albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<AlbumInfo>,
      artists: null == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<ArtistInfo>,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioQueryStateCopyWith<$Res>
    implements $AudioQueryStateCopyWith<$Res> {
  factory _$$_AudioQueryStateCopyWith(
          _$_AudioQueryState value, $Res Function(_$_AudioQueryState) then) =
      __$$_AudioQueryStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SongInfo> songs,
      List<AlbumInfo> albums,
      List<ArtistInfo> artists,
      bool isProcessing,
      Object? error,
      StackTrace? stackTrace});
}

/// @nodoc
class __$$_AudioQueryStateCopyWithImpl<$Res>
    extends _$AudioQueryStateCopyWithImpl<$Res, _$_AudioQueryState>
    implements _$$_AudioQueryStateCopyWith<$Res> {
  __$$_AudioQueryStateCopyWithImpl(
      _$_AudioQueryState _value, $Res Function(_$_AudioQueryState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? albums = null,
    Object? artists = null,
    Object? isProcessing = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$_AudioQueryState(
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<SongInfo>,
      albums: null == albums
          ? _value._albums
          : albums // ignore: cast_nullable_to_non_nullable
              as List<AlbumInfo>,
      artists: null == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<ArtistInfo>,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_AudioQueryState extends _AudioQueryState {
  const _$_AudioQueryState(
      {required final List<SongInfo> songs,
      required final List<AlbumInfo> albums,
      required final List<ArtistInfo> artists,
      this.isProcessing = false,
      this.error,
      this.stackTrace})
      : _songs = songs,
        _albums = albums,
        _artists = artists,
        super._();

  final List<SongInfo> _songs;
  @override
  List<SongInfo> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  final List<AlbumInfo> _albums;
  @override
  List<AlbumInfo> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  final List<ArtistInfo> _artists;
  @override
  List<ArtistInfo> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'AudioQueryState(songs: $songs, albums: $albums, artists: $artists, isProcessing: $isProcessing, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioQueryState &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_songs),
      const DeepCollectionEquality().hash(_albums),
      const DeepCollectionEquality().hash(_artists),
      isProcessing,
      const DeepCollectionEquality().hash(error),
      stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioQueryStateCopyWith<_$_AudioQueryState> get copyWith =>
      __$$_AudioQueryStateCopyWithImpl<_$_AudioQueryState>(this, _$identity);
}

abstract class _AudioQueryState extends AudioQueryState {
  const factory _AudioQueryState(
      {required final List<SongInfo> songs,
      required final List<AlbumInfo> albums,
      required final List<ArtistInfo> artists,
      final bool isProcessing,
      final Object? error,
      final StackTrace? stackTrace}) = _$_AudioQueryState;
  const _AudioQueryState._() : super._();

  @override
  List<SongInfo> get songs;
  @override
  List<AlbumInfo> get albums;
  @override
  List<ArtistInfo> get artists;
  @override
  bool get isProcessing;
  @override
  Object? get error;
  @override
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$_AudioQueryStateCopyWith<_$_AudioQueryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AudioQueryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getAudioFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getAudioFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getAudioFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAudioFiles value) getAudioFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAudioFiles value)? getAudioFiles,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAudioFiles value)? getAudioFiles,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioQueryEventCopyWith<$Res> {
  factory $AudioQueryEventCopyWith(
          AudioQueryEvent value, $Res Function(AudioQueryEvent) then) =
      _$AudioQueryEventCopyWithImpl<$Res, AudioQueryEvent>;
}

/// @nodoc
class _$AudioQueryEventCopyWithImpl<$Res, $Val extends AudioQueryEvent>
    implements $AudioQueryEventCopyWith<$Res> {
  _$AudioQueryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetAudioFilesCopyWith<$Res> {
  factory _$$GetAudioFilesCopyWith(
          _$GetAudioFiles value, $Res Function(_$GetAudioFiles) then) =
      __$$GetAudioFilesCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetAudioFilesCopyWithImpl<$Res>
    extends _$AudioQueryEventCopyWithImpl<$Res, _$GetAudioFiles>
    implements _$$GetAudioFilesCopyWith<$Res> {
  __$$GetAudioFilesCopyWithImpl(
      _$GetAudioFiles _value, $Res Function(_$GetAudioFiles) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetAudioFiles extends GetAudioFiles {
  const _$GetAudioFiles() : super._();

  @override
  String toString() {
    return 'AudioQueryEvent.getAudioFiles()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetAudioFiles);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getAudioFiles,
  }) {
    return getAudioFiles();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getAudioFiles,
  }) {
    return getAudioFiles?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getAudioFiles,
    required TResult orElse(),
  }) {
    if (getAudioFiles != null) {
      return getAudioFiles();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAudioFiles value) getAudioFiles,
  }) {
    return getAudioFiles(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAudioFiles value)? getAudioFiles,
  }) {
    return getAudioFiles?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAudioFiles value)? getAudioFiles,
    required TResult orElse(),
  }) {
    if (getAudioFiles != null) {
      return getAudioFiles(this);
    }
    return orElse();
  }
}

abstract class GetAudioFiles extends AudioQueryEvent {
  const factory GetAudioFiles() = _$GetAudioFiles;
  const GetAudioFiles._() : super._();
}
