import 'package:flutter/material.dart';
import 'package:sane_gallery/src/shared/platform_checks.dart';

class MobileOnlyWidget extends StatelessWidget {
  final Widget child;

  const MobileOnlyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return isMobile ? child : const SizedBox.shrink();
  }
}
