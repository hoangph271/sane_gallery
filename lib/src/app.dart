import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/gifs/gifs_view.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/settings/settings_view.dart';

/// The Widget that configures your application.
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
        return MaterialApp(
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

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  default:
                    return GifsView(
                      settingsController: settingsController,
                      gifsController: gifsController,
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
