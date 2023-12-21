import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_grid/gif_card.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';

class GifsGrid extends StatelessWidget {
  const GifsGrid({
    super.key,
    required this.gifs,
    required this.settingsController,
  });

  final List<GifObject> gifs;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final crossAxisCount =
            constraints.maxWidth ~/ 300 > 6 ? 6 : constraints.maxWidth ~/ 300;

        return GridView.builder(
          itemCount: gifs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 4 / 3,
          ),
          itemBuilder: ((context, index) {
            final gif = gifs[index];

            return GifCard(gif: gif, settingsController: settingsController);
          }),
        );
      },
    );
  }
}
