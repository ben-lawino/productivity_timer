import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final VoidCallback? onPressed;

  const SettingButton({
    required this.color,
    required this.text,
    required this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      color: color,
      onPressed: (){},
    );
  }
}