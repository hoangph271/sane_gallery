import 'package:flutter/material.dart';

class InstaxCard extends StatelessWidget {
  const InstaxCard({
    super.key,
    required this.imageProvider,
  });

  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RotatedBox(
        // TODO: calculate quarterTurns based on image orientation
        quarterTurns: 0,
        child: AspectRatio(
          aspectRatio: 2.1 / 3.4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(125),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Align(
                alignment: Alignment.topCenter,
                child: AspectRatio(
                  aspectRatio: 1.8 / 2.4,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
