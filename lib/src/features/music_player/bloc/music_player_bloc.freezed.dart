// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MusicPlayerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            ConcatenatingAudioSource playlist, int currentIndex)
        playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MusicPlayerInitial value) initial,
    required TResult Function(MusicPlayerPlaying value) playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MusicPlayerInitial value)? initial,
    TResult? Function(MusicPlayerPlaying value)? playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MusicPlayerInitial value)? initial,
    TResult Function(MusicPlayerPlaying value)? playing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicPlayerStateCopyWith<$Res> {
  factory $MusicPlayerStateCopyWith(
          MusicPlayerState value, $Res Function(MusicPlayerState) then) =
      _$MusicPlayerStateCopyWithImpl<$Res, MusicPlayerState>;
}

/// @nodoc
class _$MusicPlayerStateCopyWithImpl<$Res, $Val extends MusicPlayerState>
    implements $MusicPlayerStateCopyWith<$Res> {
  _$MusicPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MusicPlayerInitialCopyWith<$Res> {
  factory _$$MusicPlayerInitialCopyWith(_$MusicPlayerInitial value,
          $Res Function(_$MusicPlayerInitial) then) =
      __$$MusicPlayerInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MusicPlayerInitialCopyWithImpl<$Res>
    extends _$MusicPlayerStateCopyWithImpl<$Res, _$MusicPlayerInitial>
    implements _$$MusicPlayerInitialCopyWith<$Res> {
  __$$MusicPlayerInitialCopyWithImpl(
      _$MusicPlayerInitial _value, $Res Function(_$MusicPlayerInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MusicPlayerInitial extends MusicPlayerInitial {
  const _$MusicPlayerInitial() : super._();

  @override
  String toString() {
    return 'MusicPlayerState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MusicPlayerInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            ConcatenatingAudioSource playlist, int currentIndex)
        playing,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
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
    required TResult Function(MusicPlayerInitial value) initial,
    required TResult Function(MusicPlayerPlaying value) playing,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MusicPlayerInitial value)? initial,
    TResult? Function(MusicPlayerPlaying value)? playing,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MusicPlayerInitial value)? initial,
    TResult Function(MusicPlayerPlaying value)? playing,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MusicPlayerInitial extends MusicPlayerState {
  const factory MusicPlayerInitial() = _$MusicPlayerInitial;
  const MusicPlayerInitial._() : super._();
}

/// @nodoc
abstract class _$$MusicPlayerPlayingCopyWith<$Res> {
  factory _$$MusicPlayerPlayingCopyWith(_$MusicPlayerPlaying value,
          $Res Function(_$MusicPlayerPlaying) then) =
      __$$MusicPlayerPlayingCopyWithImpl<$Res>;
  @useResult
  $Res call({ConcatenatingAudioSource playlist, int currentIndex});
}

/// @nodoc
class __$$MusicPlayerPlayingCopyWithImpl<$Res>
    extends _$MusicPlayerStateCopyWithImpl<$Res, _$MusicPlayerPlaying>
    implements _$$MusicPlayerPlayingCopyWith<$Res> {
  __$$MusicPlayerPlayingCopyWithImpl(
      _$MusicPlayerPlaying _value, $Res Function(_$MusicPlayerPlaying) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlist = null,
    Object? currentIndex = null,
  }) {
    return _then(_$MusicPlayerPlaying(
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as ConcatenatingAudioSource,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MusicPlayerPlaying extends MusicPlayerPlaying {
  const _$MusicPlayerPlaying(
      {required this.playlist, required this.currentIndex})
      : super._();

  @override
  final ConcatenatingAudioSource playlist;
  @override
  final int currentIndex;

  @override
  String toString() {
    return 'MusicPlayerState.playing(playlist: $playlist, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MusicPlayerPlaying &&
            (identical(other.playlist, playlist) ||
                other.playlist == playlist) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playlist, currentIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MusicPlayerPlayingCopyWith<_$MusicPlayerPlaying> get copyWith =>
      __$$MusicPlayerPlayingCopyWithImpl<_$MusicPlayerPlaying>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            ConcatenatingAudioSource playlist, int currentIndex)
        playing,
  }) {
    return playing(playlist, currentIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
  }) {
    return playing?.call(playlist, currentIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ConcatenatingAudioSource playlist, int currentIndex)?
        playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(playlist, currentIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MusicPlayerInitial value) initial,
    required TResult Function(MusicPlayerPlaying value) playing,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MusicPlayerInitial value)? initial,
    TResult? Function(MusicPlayerPlaying value)? playing,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MusicPlayerInitial value)? initial,
    TResult Function(MusicPlayerPlaying value)? playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class MusicPlayerPlaying extends MusicPlayerState {
  const factory MusicPlayerPlaying(
      {required final ConcatenatingAudioSource playlist,
      required final int currentIndex}) = _$MusicPlayerPlaying;
  const MusicPlayerPlaying._() : super._();

  ConcatenatingAudioSource get playlist;
  int get currentIndex;
  @JsonKey(ignore: true)
  _$$MusicPlayerPlayingCopyWith<_$MusicPlayerPlaying> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MusicPlayerEvent {
  ConcatenatingAudioSource get playlist => throw _privateConstructorUsedError;
  int get selectedSongIndex => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ConcatenatingAudioSource playlist, int selectedSongIndex)
        playPlaylist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConcatenatingAudioSource playlist, int selectedSongIndex)?
        playPlaylist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConcatenatingAudioSource playlist, int selectedSongIndex)?
        playPlaylist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MusicPlayerPlayPlaylist value) playPlaylist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MusicPlayerPlayPlaylist value)? playPlaylist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MusicPlayerPlayPlaylist value)? playPlaylist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MusicPlayerEventCopyWith<MusicPlayerEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicPlayerEventCopyWith<$Res> {
  factory $MusicPlayerEventCopyWith(
          MusicPlayerEvent value, $Res Function(MusicPlayerEvent) then) =
      _$MusicPlayerEventCopyWithImpl<$Res, MusicPlayerEvent>;
  @useResult
  $Res call({ConcatenatingAudioSource playlist, int selectedSongIndex});
}

/// @nodoc
class _$MusicPlayerEventCopyWithImpl<$Res, $Val extends MusicPlayerEvent>
    implements $MusicPlayerEventCopyWith<$Res> {
  _$MusicPlayerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlist = null,
    Object? selectedSongIndex = null,
  }) {
    return _then(_value.copyWith(
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as ConcatenatingAudioSource,
      selectedSongIndex: null == selectedSongIndex
          ? _value.selectedSongIndex
          : selectedSongIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MusicPlayerPlayPlaylistCopyWith<$Res>
    implements $MusicPlayerEventCopyWith<$Res> {
  factory _$$MusicPlayerPlayPlaylistCopyWith(_$MusicPlayerPlayPlaylist value,
          $Res Function(_$MusicPlayerPlayPlaylist) then) =
      __$$MusicPlayerPlayPlaylistCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ConcatenatingAudioSource playlist, int selectedSongIndex});
}

/// @nodoc
class __$$MusicPlayerPlayPlaylistCopyWithImpl<$Res>
    extends _$MusicPlayerEventCopyWithImpl<$Res, _$MusicPlayerPlayPlaylist>
    implements _$$MusicPlayerPlayPlaylistCopyWith<$Res> {
  __$$MusicPlayerPlayPlaylistCopyWithImpl(_$MusicPlayerPlayPlaylist _value,
      $Res Function(_$MusicPlayerPlayPlaylist) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlist = null,
    Object? selectedSongIndex = null,
  }) {
    return _then(_$MusicPlayerPlayPlaylist(
      playlist: null == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as ConcatenatingAudioSource,
      selectedSongIndex: null == selectedSongIndex
          ? _value.selectedSongIndex
          : selectedSongIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MusicPlayerPlayPlaylist extends MusicPlayerPlayPlaylist {
  const _$MusicPlayerPlayPlaylist(
      {required this.playlist, required this.selectedSongIndex})
      : super._();

  @override
  final ConcatenatingAudioSource playlist;
  @override
  final int selectedSongIndex;

  @override
  String toString() {
    return 'MusicPlayerEvent.playPlaylist(playlist: $playlist, selectedSongIndex: $selectedSongIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MusicPlayerPlayPlaylist &&
            (identical(other.playlist, playlist) ||
                other.playlist == playlist) &&
            (identical(other.selectedSongIndex, selectedSongIndex) ||
                other.selectedSongIndex == selectedSongIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playlist, selectedSongIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MusicPlayerPlayPlaylistCopyWith<_$MusicPlayerPlayPlaylist> get copyWith =>
      __$$MusicPlayerPlayPlaylistCopyWithImpl<_$MusicPlayerPlayPlaylist>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ConcatenatingAudioSource playlist, int selectedSongIndex)
        playPlaylist,
  }) {
    return playPlaylist(playlist, selectedSongIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConcatenatingAudioSource playlist, int selectedSongIndex)?
        playPlaylist,
  }) {
    return playPlaylist?.call(playlist, selectedSongIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConcatenatingAudioSource playlist, int selectedSongIndex)?
        playPlaylist,
    required TResult orElse(),
  }) {
    if (playPlaylist != null) {
      return playPlaylist(playlist, selectedSongIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MusicPlayerPlayPlaylist value) playPlaylist,
  }) {
    return playPlaylist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MusicPlayerPlayPlaylist value)? playPlaylist,
  }) {
    return playPlaylist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MusicPlayerPlayPlaylist value)? playPlaylist,
    required TResult orElse(),
  }) {
    if (playPlaylist != null) {
      return playPlaylist(this);
    }
    return orElse();
  }
}

abstract class MusicPlayerPlayPlaylist extends MusicPlayerEvent {
  const factory MusicPlayerPlayPlaylist(
      {required final ConcatenatingAudioSource playlist,
      required final int selectedSongIndex}) = _$MusicPlayerPlayPlaylist;
  const MusicPlayerPlayPlaylist._() : super._();

  @override
  ConcatenatingAudioSource get playlist;
  @override
  int get selectedSongIndex;
  @override
  @JsonKey(ignore: true)
  _$$MusicPlayerPlayPlaylistCopyWith<_$MusicPlayerPlayPlaylist> get copyWith =>
      throw _privateConstructorUsedError;
}
