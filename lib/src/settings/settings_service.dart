import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<String> apiRoot() async => 'https://api.giphy.com/v1';
  Future<String> apiKey() async => 'ao3o2pNEYof5LZn2xixB7e1pVm7k1Xu4';
  Future<int> searchLimit() async => 8;

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<String>> favoriteIds() async {
    final prefs = await getSharedPreferences();

    List<String> ids = prefs.getStringList("@favorites") ?? [];

    return ids;
  }

  Future<void> setFavorites(List<String> ids) async {
    (await getSharedPreferences()).setStringList("@favorites", ids);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
}
