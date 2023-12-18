import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

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

        return Expanded(
          child: GridView.builder(
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
          ),
        );
      },
    );
  }
}

class GifCard extends StatefulWidget {
  final SettingsController settingsController;

  const GifCard({
    super.key,
    required this.gif,
    required this.settingsController,
  });

  final GifObject gif;

  @override
  State<GifCard> createState() => _GifCardState();
}

class _GifCardState extends State<GifCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorited =
        widget.settingsController.favoriteIds.contains(widget.gif.id);

    return Card(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.gif.images.original.url),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.grey.withOpacity(0.4),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
            child: SanePadding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    widget.gif.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
                  IconButton.filledTonal(
                    icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      if (isFavorited) {
                        widget.settingsController.removeFavorite(widget.gif.id);
                      } else {
                        widget.settingsController.addFavorite(widget.gif.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
