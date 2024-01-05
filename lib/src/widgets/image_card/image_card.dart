import 'package:flutter/material.dart';
import 'package:sane_gallery/src/widgets/gif_card.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.widget,
    required this.imageProvider,
    this.cardCaption,
  });

  final GifCard widget;
  final ImageProvider<Object> imageProvider;
  final Widget? cardCaption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: cardCaption,
    );
  }
}
