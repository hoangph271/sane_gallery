import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

Future<Widget> initApp() async {
  final settingsController = SettingsController(SettingsService());
  final gifsController = GifsController(GifsService());

  await Future.wait([
    settingsController.init(),
    gifsController.init(),
  ]);

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<SettingsController>(
        create: (context) => settingsController,
      ),
      ChangeNotifierProvider<GifsController>(
        create: (context) => gifsController,
      ),
    ],
    child: SaneGalleryApp(),
  );
}
