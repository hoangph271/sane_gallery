import 'package:flutter/material.dart';
import 'src/gifs/gifs_controller.dart';
import 'src/gifs/gifs_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await initApp();

  runApp(app);
}

Future<SaneGallery> initApp() async {
  final settingsController = SettingsController(SettingsService());
  final gifsController = GifsController(GifsService());

  await Future.wait([
    settingsController.init(),
    gifsController.init(),
  ]);

  return SaneGallery(
    settingsController: settingsController,
    gifsController: gifsController,
  );
}
