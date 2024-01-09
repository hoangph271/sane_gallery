import 'package:go_router/go_router.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/gifs/gifs_view.dart';
import 'package:sane_gallery/src/magic_toolbox/magic_toolbox.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

routerConfig(
  SettingsController settingsController,
  GifsController gifsController,
) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: GifsView.pathName,
        builder: (context, state) => GifsView(
          settingsController: settingsController,
          gifsController: gifsController,
        ),
      ),
      GoRoute(
        path: MagicToolbox.pathName,
        builder: (context, state) => const MagicToolbox(),
      ),
    ],
  );

  return router;
}
