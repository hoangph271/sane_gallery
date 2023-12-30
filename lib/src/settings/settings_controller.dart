import 'package:flutter/material.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  late String _apiRoot;
  late String _apiKey;
  late int _searchLimit;
  // late List<String> _favoriteIds;

  ThemeMode get themeMode => _themeMode;
  String get apiRoot => _apiRoot;
  String get apiKey => _apiKey;
  int get searchLimit => _searchLimit;
  // List<String> get favoriteIds => _favoriteIds;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> init() async {
    _themeMode = await _settingsService.themeMode();
    _apiRoot = await _settingsService.apiRoot();
    _apiKey = await _settingsService.apiKey();
    _searchLimit = await _settingsService.searchLimit();
    // _favoriteIds = await _settingsService.favoriteIds();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  // Future<void> addFavorite(String id) async {
  //   if (!_favoriteIds.contains(id)) {
  //     _favoriteIds.add(id);
  //     notifyListeners();
  //   }

  //   await _settingsService.setFavorites(_favoriteIds);
  // }

  // Future<void> removeFavorite(String id) async {
  //   if (_favoriteIds.remove(id)) {
  //     notifyListeners();
  //   }

  //   await _settingsService.setFavorites(_favoriteIds);
  // }
}
