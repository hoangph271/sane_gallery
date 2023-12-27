import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await initApp();

  runApp(app);
}

Future<SaneGallery> initApp() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  return SaneGallery(settingsController: settingsController);
}
