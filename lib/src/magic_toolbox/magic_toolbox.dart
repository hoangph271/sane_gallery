import 'package:flutter/material.dart';

class MagicToolbox extends StatefulWidget {
  static const pathName = '/magic-toolbox';

  const MagicToolbox({super.key});

  @override
  State<MagicToolbox> createState() => _MagicToolboxState();
}

class _MagicToolboxState extends State<MagicToolbox> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(child: Text('Magic Toolbox')),
      ),
    );
  }
}
