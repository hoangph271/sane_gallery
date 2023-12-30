import 'package:flutter/material.dart';
import 'package:sane_gallery/src/shared/shared_preferences.dart';

const defaultPageSize = 8;
const String pageSizeSharedPreferencesKey = '@settings-page-size';

class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<String> apiRoot() async => 'https://api.giphy.com/v1';
  Future<String> apiKey() async => 'ao3o2pNEYof5LZn2xixB7e1pVm7k1Xu4';

  Future<int> pageSize() async {
    return (await getSharedPreferences())
            .getInt(pageSizeSharedPreferencesKey) ??
        defaultPageSize;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // TODO: Use the shared_preferences package to persist settings locally
  }

  Future<void> updateSearchLimit(int limit) async {
    (await getSharedPreferences()).setInt(pageSizeSharedPreferencesKey, limit);
  }
}
