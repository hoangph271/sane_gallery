import 'package:flutter/material.dart';

enum PaddingSize { small, normal, large }

extension SizeInPixels on PaddingSize {
  double get sizeInPixels {
    switch (this) {
      case PaddingSize.small:
        return 8;
      case PaddingSize.normal:
        return 16;
      case PaddingSize.large:
        return 24;
    }
  }
}

class SanePadding extends StatelessWidget {
  final Widget child;
  final PaddingSize paddingSize;

  const SanePadding(
      {super.key, required this.child, this.paddingSize = PaddingSize.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize.sizeInPixels),
      child: child,
    );
  }
}
