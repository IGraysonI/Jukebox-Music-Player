/// {@template tag}
/// `Tag` class represent an ID3 Tag.
/// It represent both ID3V1 and ID3V2 tags.
/// {@endtemplate}
class Tag {
  /// Title of the track
  String? title;

  /// Artist of the track
  String? artist;

  /// Genre of the track
  String? genre;

  /// Number of the track in the album
  String? trackNumber;

  /// Total number of tracks in the album
  String? trackTotal;

  /// Number of the disc in the artist discography
  String? discNumber;

  /// Total number of discs in the artist discography
  String? discTotal;

  /// Lyrics of the track
  String? lyrics;

  /// Custom comment
  String? comment;

  /// Album of the track
  String? album;

  /// Artist of the album
  String? albumArtist;

  /// Year of publication
  String? year;

  /// Artwork path
  String? artwork;

  /// Default constructor
  Tag({
    this.title,
    this.artist,
    this.genre,
    this.trackNumber,
    this.trackTotal,
    this.discNumber,
    this.discTotal,
    this.lyrics,
    this.comment,
    this.album,
    this.albumArtist,
    this.year,
    this.artwork,
  });

  /// Create a `Tag` object from a `Map` of the tags.
  Tag.fromMap(Map<String, dynamic> map) {
    title = map["title"] as String?;
    artist = map["artist"] as String?;
    genre = map["genre"] as String?;
    trackNumber = map["trackNumber"] as String?;
    trackTotal = map["trackTotal"] as String?;
    discNumber = map["discNumber"] as String?;
    discTotal = map["discTotal"] as String?;
    lyrics = map["lyrics"] as String?;
    comment = map["comment"] as String?;
    album = map["album"] as String?;
    albumArtist = map["albumArtist"] as String?;
    year = map["year"] as String?;
    artwork = map["artwork"] as String?;
  }

  /// Get a `Map` of the tags from a `Tag` object.
  Map<String, String?> toMap() => <String, String?>{
        "title": title,
        "artist": artist,
        "genre": genre,
        "trackNumber": trackNumber,
        "trackTotal": trackTotal,
        "discNumber": discNumber,
        "discTotal": discTotal,
        "lyrics": lyrics,
        "comment": comment,
        "album": album,
        "albumArtist": albumArtist,
        "year": year,
        "artwork": artwork,
      };
}
