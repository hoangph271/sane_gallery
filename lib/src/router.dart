import 'package:go_router/go_router.dart';
import 'package:sane_gallery/src/main/main_view.dart';
import 'package:sane_gallery/src/magic_toolbox/magic_toolbox.dart';

final saneGalleryRouter = GoRouter(
  routes: [
    GoRoute(
      path: MainView.pathName,
      builder: (context, state) => const MainView(),
    ),
    GoRoute(
      path: MagicToolbox.pathName,
      builder: (context, state) => const MagicToolbox(),
    ),
  ],
);
