import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/image_card/card_caption.dart';
import 'package:sane_gallery/src/widgets/image_card/image_card.dart';
import 'package:sane_gallery/src/widgets/instax_card.dart';

class GifCard extends StatefulWidget {
  final SettingsController settingsController;
  final GifsController gifsController;

  const GifCard({
    super.key,
    required this.gif,
    required this.settingsController,
    required this.gifsController,
  });

  final GifObject gif;

  @override
  State<GifCard> createState() => _GifCardState();
}

class _GifCardState extends State<GifCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorited =
        widget.gifsController.favoriteIds.contains(widget.gif.id);

    return CachedNetworkImage(
      imageUrl: widget.gif.previewUrl,
      placeholder: (context, url) => CachedNetworkImage(
        imageUrl: widget.gif.thumbnailUrl,
        fit: BoxFit.cover,
      ),
      imageBuilder: (context, imageProvider) {
        return FlipCard(
            front: Card(
                child: ImageCard(
              widget: widget,
              isFavorited: isFavorited,
              imageProvider: imageProvider,
              cardCaption: CardCaption(
                widget: widget,
                isFavorited: isFavorited,
              ),
            )),
            back: InstaxCard(
              imageProvider: imageProvider,
            ));
      },
    );
  }
}
