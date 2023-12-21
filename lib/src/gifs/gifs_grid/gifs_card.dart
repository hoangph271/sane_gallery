import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/shared/sane_padding.dart';

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
      child: CachedNetworkImage(
        imageUrl: widget.gif.previewUrl,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
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
                        icon: Icon(isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          if (isFavorited) {
                            widget.settingsController
                                .removeFavorite(widget.gif.id);
                          } else {
                            widget.settingsController
                                .addFavorite(widget.gif.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
