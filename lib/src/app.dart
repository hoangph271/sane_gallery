import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sane_gallery/src/screens/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/router.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

class SaneGallery extends StatelessWidget {
  final SettingsController settingsController;
  final GifsController gifsController;

  const SaneGallery({
    super.key,
    required this.settingsController,
    required this.gifsController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([settingsController, gifsController]),
      builder: (BuildContext context, Widget? _) {
        return MaterialApp.router(
          // * Providing a restorationScopeId allows the Navigator built by the
          // * MaterialApp to restore the navigation stack when a user leaves and
          // * returns to the app after it has been killed while running in the
          // * background.
          restorationScopeId: 'app',
          // * Provide the generated AppLocalizations to the MaterialApp. This
          // * allows descendant Widgets to display the correct translations
          // * depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],

          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          routerConfig: routerConfig(
            settingsController,
            gifsController,
          ),
        );
      },
    );
  }
}
