import 'package:flutter/material.dart';
import 'package:sane_gallery/src/widgets/favorite_button.dart';
import 'package:sane_gallery/src/widgets/gif_card.dart';
import 'package:sane_gallery/src/widgets/sane_padding.dart';

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
