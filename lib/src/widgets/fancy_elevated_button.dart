import 'package:flutter/material.dart';

class FancyElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  final Widget? label;

  const FancyElevatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8),
        child: label,
      ),
      icon: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: icon,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
