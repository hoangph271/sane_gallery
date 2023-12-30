import 'package:flutter/material.dart';
import 'package:sane_gallery/src/widgets/gif_card.dart';

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
