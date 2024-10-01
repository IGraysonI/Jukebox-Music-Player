/// {@template navigation_tabs_enum}
/// NavigationTabsEnum enumeration
/// {@endtemplate}
enum NavigationTabsEnum implements Comparable<NavigationTabsEnum> {
  /// Songs
  songs('songs'),

  /// Albums
  albums('albums'),

  /// Artists
  artists('artists');

  /// {@macro navigation_tabs_enum}
  const NavigationTabsEnum(this.name);

  /// Value of the enum
  final String name;

  /// Creates a new instance of [NavigationTabsEnum] from a given [String] value.
  static NavigationTabsEnum fromValue(String? value,
          {NavigationTabsEnum? fallback}) =>
      switch (value?.trim().toLowerCase()) {
        'songs' => songs,
        'albums' => albums,
        'artists' => artists,
        _ => fallback ?? (throw ArgumentError.value(value))
      };

  /// Pattern matching.
  T map<T>({
    required T Function() songs,
    required T Function() albums,
    required T Function() artists,
  }) =>
      switch (this) {
        NavigationTabsEnum.songs => songs(),
        NavigationTabsEnum.albums => albums(),
        NavigationTabsEnum.artists => artists(),
      };

  /// Pattern matching.
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? songs,
    T Function()? albums,
    T Function()? artists,
  }) =>
      map<T>(
        songs: songs ?? orElse,
        albums: albums ?? orElse,
        artists: artists ?? orElse,
      );

  /// Pattern matching.
  T? maybeMapOrNull<T>({
    T Function()? songs,
    T Function()? albums,
    T Function()? artists,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        songs: songs,
        albums: albums,
        artists: artists,
      );

  @override
  int compareTo(NavigationTabsEnum other) => index.compareTo(other.index);

  @override
  String toString() => name;
}
