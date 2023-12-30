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
  late int _pageSize;

  ThemeMode get themeMode => _themeMode;
  String get apiRoot => _apiRoot;
  String get apiKey => _apiKey;
  int get pageSize => _pageSize;

  Future<void> init() async {
    _themeMode = await _settingsService.themeMode();
    _apiRoot = await _settingsService.apiRoot();
    _apiKey = await _settingsService.apiKey();
    _pageSize = await _settingsService.pageSize();

    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateSearchLimitRange(int limit) async {
    if (_pageSize == limit) return;

    _pageSize = limit;

    notifyListeners();

    await _settingsService.updateSearchLimit(limit);
  }
}
