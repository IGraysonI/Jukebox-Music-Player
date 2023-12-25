/// @{template audio_file}
/// `AudioFile` class represent the MP3 header of the file.
/// It contains useful and tecnhical informations about the file.
///
/// It is a read-only class. You can't actually edit this infos in the MP3 file.
/// @{endtemplate}
class AudioFile {
  /// Track length in seconds
  int? length;

  /// Bitrate of the file
  int? bitRate;

  /// The channel mode (such as `Stereo` or `Mono`)
  String? channels;

  /// The audio file type (such as `mp3`)
  String? encodingType;

  /// The audio file format (such as `MPEG-1 Layer 3`)
  String? format;

  /// The sampling rate
  int? sampleRate;

  /// If the bitrate is variable
  bool? isVariableBitRate;

  /// Default constructor
  AudioFile({
    this.length,
    this.bitRate,
    this.channels,
    this.encodingType,
    this.format,
    this.sampleRate,
    this.isVariableBitRate,
  });

  //FIXME: remove "as"
  /// Create an `AudioFile` object from a `Map` of the infos.
  AudioFile.fromMap(Map<String, dynamic> map) {
    length = map["length"] as int?;
    bitRate = map["bitRate"] as int?;
    channels = map["channels"] as String?;
    encodingType = map["encodingType"] as String?;
    format = map["format"] as String?;
    sampleRate = map["sampleRate"] as int?;
    isVariableBitRate = map["isVariableBitRate"] as bool?;
  }

  /// Get a `Map` of the infos from an `AudioFile` object.
  Map<String, dynamic> toMap() => <String, dynamic>{
        "length": length,
        "bitRate": bitRate,
        "channels": channels,
        "encodingType": encodingType,
        "format": format,
        "sampleRate": sampleRate,
        "isVariableBitRate": isVariableBitRate,
      };
}
