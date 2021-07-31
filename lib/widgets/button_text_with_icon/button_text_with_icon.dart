import 'package:flutter/material.dart';

class ButtonTextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;

  const ButtonTextWithIcon({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
