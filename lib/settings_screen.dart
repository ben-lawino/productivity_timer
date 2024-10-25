import 'package:flutter/material.dart';
import 'package:productivity_timer/setting_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextStyle textStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 3,
          scrollDirection: Axis.vertical,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            Text(
              "Work",
              style: textStyle,
            ),
            const SizedBox(), // Spacer
            const SizedBox(), // Spacer
            SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
              ),
            ),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
              ),
            ),
            Text(
              "Short",
              style: textStyle,
            ),
            const SizedBox(),
            const SizedBox(),
            SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
              ),
            ),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
              ),
            ),
            Text(
              "Long",
              style: textStyle,
            ),
            const SizedBox(),
            const SizedBox(),
            SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
              ),
            ),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
