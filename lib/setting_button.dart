import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String?, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String? setting;
  final CallbackSetting callback;

  const SettingButton({
    required this.color,
    required this.text,
    required this.value,
    this.setting,
    required this.callback, // `required` added since it's non-nullable
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      color: color,
      onPressed: () => callback(setting, value),
    );
  }
}
