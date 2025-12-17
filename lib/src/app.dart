import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sane_gallery/src/router.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

import 'localization/app_localizations.dart';

class SaneGalleryApp extends StatelessWidget {
  const SaneGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? _) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          routerConfig: saneGalleryRouter,
        );
      },
    );
  }
}
