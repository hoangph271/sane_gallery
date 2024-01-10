import 'package:go_router/go_router.dart';
import 'package:sane_gallery/src/gifs/gifs_view.dart';
import 'package:sane_gallery/src/magic_toolbox/magic_toolbox.dart';

final saneRouter = GoRouter(
  routes: [
    GoRoute(
      path: GifsView.pathName,
      builder: (context, state) => const GifsView(),
    ),
    GoRoute(
      path: MagicToolbox.pathName,
      builder: (context, state) => const MagicToolbox(),
    ),
  ],
);
