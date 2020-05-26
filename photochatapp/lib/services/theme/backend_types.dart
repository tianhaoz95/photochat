/// Defines how the theme settings
/// persists.
enum ThemeBackendType {
  /// Indicates that the theme settings should
  /// use a dummy backend that does nothing.
  /// With the [MOCK] backend, the theme settings
  /// will be cleared every time the app reloads.
  /// It should only be used when doing local
  /// development and unit testing.
  MOCK,

  /// Indicates that the theme settings should
  /// use a [Hive](https://pub.dev/packages/hive)
  /// local key-val storage as backend to persist
  /// theme settings.
  HIVE,
}
