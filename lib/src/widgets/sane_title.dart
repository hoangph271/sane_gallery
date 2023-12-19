import 'package:flutter/material.dart';

class SaneTitle extends StatelessWidget {
  const SaneTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Sane',
          style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize)),
      TextSpan(
          text: 'Gallery',
          style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize)),
    ]));
  }
}
