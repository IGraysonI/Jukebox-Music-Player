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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)
        data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioQueryInitial value) initial,
    required TResult Function(AudioQueryData value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioQueryInitial value)? initial,
    TResult? Function(AudioQueryData value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioQueryInitial value)? initial,
    TResult Function(AudioQueryData value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioQueryStateCopyWith<$Res> {
  factory $AudioQueryStateCopyWith(
          AudioQueryState value, $Res Function(AudioQueryState) then) =
      _$AudioQueryStateCopyWithImpl<$Res, AudioQueryState>;
}

/// @nodoc
class _$AudioQueryStateCopyWithImpl<$Res, $Val extends AudioQueryState>
    implements $AudioQueryStateCopyWith<$Res> {
  _$AudioQueryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AudioQueryInitialCopyWith<$Res> {
  factory _$$AudioQueryInitialCopyWith(
          _$AudioQueryInitial value, $Res Function(_$AudioQueryInitial) then) =
      __$$AudioQueryInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AudioQueryInitialCopyWithImpl<$Res>
    extends _$AudioQueryStateCopyWithImpl<$Res, _$AudioQueryInitial>
    implements _$$AudioQueryInitialCopyWith<$Res> {
  __$$AudioQueryInitialCopyWithImpl(
      _$AudioQueryInitial _value, $Res Function(_$AudioQueryInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AudioQueryInitial extends AudioQueryInitial {
  const _$AudioQueryInitial() : super._();

  @override
  String toString() {
    return 'AudioQueryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AudioQueryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)
        data,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioQueryInitial value) initial,
    required TResult Function(AudioQueryData value) data,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioQueryInitial value)? initial,
    TResult? Function(AudioQueryData value)? data,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioQueryInitial value)? initial,
    TResult Function(AudioQueryData value)? data,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AudioQueryInitial extends AudioQueryState {
  const factory AudioQueryInitial() = _$AudioQueryInitial;
  const AudioQueryInitial._() : super._();
}

/// @nodoc
abstract class _$$AudioQueryDataCopyWith<$Res> {
  factory _$$AudioQueryDataCopyWith(
          _$AudioQueryData value, $Res Function(_$AudioQueryData) then) =
      __$$AudioQueryDataCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<SongInfo> songs, List<AlbumInfo> albums, List<ArtistInfo> artists});
}

/// @nodoc
class __$$AudioQueryDataCopyWithImpl<$Res>
    extends _$AudioQueryStateCopyWithImpl<$Res, _$AudioQueryData>
    implements _$$AudioQueryDataCopyWith<$Res> {
  __$$AudioQueryDataCopyWithImpl(
      _$AudioQueryData _value, $Res Function(_$AudioQueryData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? albums = null,
    Object? artists = null,
  }) {
    return _then(_$AudioQueryData(
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
    ));
  }
}

/// @nodoc

class _$AudioQueryData extends AudioQueryData {
  const _$AudioQueryData(
      {required final List<SongInfo> songs,
      required final List<AlbumInfo> albums,
      required final List<ArtistInfo> artists})
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
  String toString() {
    return 'AudioQueryState.data(songs: $songs, albums: $albums, artists: $artists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioQueryData &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            const DeepCollectionEquality().equals(other._artists, _artists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_songs),
      const DeepCollectionEquality().hash(_albums),
      const DeepCollectionEquality().hash(_artists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioQueryDataCopyWith<_$AudioQueryData> get copyWith =>
      __$$AudioQueryDataCopyWithImpl<_$AudioQueryData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)
        data,
  }) {
    return data(songs, albums, artists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
  }) {
    return data?.call(songs, albums, artists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SongInfo> songs, List<AlbumInfo> albums,
            List<ArtistInfo> artists)?
        data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(songs, albums, artists);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioQueryInitial value) initial,
    required TResult Function(AudioQueryData value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioQueryInitial value)? initial,
    TResult? Function(AudioQueryData value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioQueryInitial value)? initial,
    TResult Function(AudioQueryData value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class AudioQueryData extends AudioQueryState {
  const factory AudioQueryData(
      {required final List<SongInfo> songs,
      required final List<AlbumInfo> albums,
      required final List<ArtistInfo> artists}) = _$AudioQueryData;
  const AudioQueryData._() : super._();

  List<SongInfo> get songs;
  List<AlbumInfo> get albums;
  List<ArtistInfo> get artists;
  @JsonKey(ignore: true)
  _$$AudioQueryDataCopyWith<_$AudioQueryData> get copyWith =>
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
