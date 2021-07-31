import 'package:flutter/material.dart';

import '../../theme/colors.dart' show white;

class ClearTextFieldButton extends StatelessWidget {
  final TextEditingController controller;

  const ClearTextFieldButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.clear,
      icon: const Icon(
        Icons.clear_rounded,
        size: 24,
        color: white,
      ),
    );
  }
}
