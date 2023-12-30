import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:sane_gallery/src/gifs/gif_model.dart';
import 'package:sane_gallery/src/gifs/gifs_controller.dart';
import 'package:sane_gallery/src/settings/settings_controller.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';

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
            back: ImageCard(
              widget: widget,
              isFavorited: isFavorited,
              imageProvider: imageProvider,
            ));
      },
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.widget,
    required this.isFavorited,
    required this.imageProvider,
    this.cardCaption,
  });

  final GifCard widget;
  final bool isFavorited;
  final ImageProvider<Object> imageProvider;
  final Widget? cardCaption;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: cardCaption,
      ),
    );
  }
}

class CardCaption extends StatelessWidget {
  const CardCaption({
    super.key,
    required this.widget,
    required this.isFavorited,
  });

  final GifCard widget;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
              Theme.of(context).primaryColor.withOpacity(0.6),
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
              FavoriteButton(
                isFavorited: isFavorited,
                widget: widget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorited,
    required this.widget,
  });

  final bool isFavorited;
  final GifCard widget;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        if (isFavorited) {
          widget.gifsController.removeFavorite(widget.gif.id);
        } else {
          widget.gifsController.addFavorite(widget.gif.id);
        }
      },
    );
  }
}
