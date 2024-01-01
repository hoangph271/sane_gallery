import 'package:flutter/material.dart';
import 'package:sane_gallery/src/shared/shared_preferences.dart';

const defaultPageSize = 8;

class SettingsSharedPreferencesKey {
  static const pageSize = '@settings-page-size';
  static const themeMode = '@settings-theme-mode';
}

class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<String> apiRoot() async => 'https://api.giphy.com/v1';
  Future<String> apiKey() async => 'ao3o2pNEYof5LZn2xixB7e1pVm7k1Xu4';

  Future<int> pageSize() async {
    return (await getSharedPreferences())
            .getInt(SettingsSharedPreferencesKey.pageSize) ??
        defaultPageSize;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<ThemeMode> updateThemeMode(ThemeMode theme) async {
    var themeModeIndex = (await getSharedPreferences())
            .getInt(SettingsSharedPreferencesKey.themeMode) ??
        ThemeMode.system.index;

    return ThemeMode.values[themeModeIndex];
  }

  Future<void> updatePageSize(int pageSize) async {
    (await getSharedPreferences())
        .setInt(SettingsSharedPreferencesKey.pageSize, pageSize);
  }
}
