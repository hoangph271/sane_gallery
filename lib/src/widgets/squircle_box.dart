import 'package:flutter/material.dart';

class SquircleBox extends StatelessWidget {
  final Widget? child;

  const SquircleBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}
