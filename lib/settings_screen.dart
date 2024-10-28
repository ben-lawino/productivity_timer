
import 'package:flutter/material.dart';
import 'package:productivity_timer/setting_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is the Settings Screen widget
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// State class for the SettingsScreen
class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences prefs; // SharedPreferences instance for storing settings
  static const String WORKTIME = "workTime"; // Key for work time
  static const String SHORTBREAK = "shortBreak"; // Key for short break time
  static const String LONGBREAK = "longBreak"; // Key for long break time

  // Default values for work and break times
  int workTime = 30;
  int shortBreak = 5;
  int longBreak = 20;

  // Text editing controllers for input fields
  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();

  @override
  void initState() {
    super.initState(); // Call the superclass's initState
    readSettings(); // Load saved settings when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'), // Title of the settings screen
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // Padding for the container
        child: GridView.count(
          crossAxisCount: 3, // Number of columns in the grid
          scrollDirection: Axis.vertical, // Vertical scrolling
          childAspectRatio: 3, // Aspect ratio for each grid cell
          crossAxisSpacing: 10, // Spacing between columns
          mainAxisSpacing: 10, // Spacing between rows
          children: [
            Text("Work", style: TextStyle(fontSize: 24)), // Work label
            const SizedBox(), // Spacer
            const SizedBox(), // Spacer
            // Decrement button for work time
            SettingButton(
              color: Color(0xff455A64),
              text: "-",
              value: -1,
              setting: WORKTIME,
              callback: updateSetting, // Pass the update function
            ),
            TextField(
              controller: txtWork, // Controller for work time input
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center, // Center text
              keyboardType: TextInputType.number, // Numeric input
            ),
            // Increment button for work time
            SettingButton(
              color: Color(0xff009688),
              text: "+",
              value: 1,
              setting: WORKTIME,
              callback: updateSetting, // Pass the update function
            ),
            Text("Short", style: TextStyle(fontSize: 24)), // Short break label
            const SizedBox(), // Spacer
            const SizedBox(), // Spacer
            // Decrement button for short break time
            SettingButton(
              color: Color(0xff455A64),
              text: "-",
              value: -1,
              setting: SHORTBREAK,
              callback: updateSetting, // Pass the update function
            ),
            TextField(
              controller: txtShort, // Controller for short break input
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center, // Center text
              keyboardType: TextInputType.number, // Numeric input
            ),
            // Increment button for short break time
            SettingButton(
              color: Color(0xff009688),
              text: "+",
              value: 1,
              setting: SHORTBREAK,
              callback: updateSetting, // Pass the update function
            ),
            Text("Long", style: TextStyle(fontSize: 24)), // Long break label
            const SizedBox(), // Spacer
            const SizedBox(), // Spacer
            // Decrement button for long break time
            SettingButton(
              color: Color(0xff455A64),
              text: "-",
              value: -1,
              setting: LONGBREAK,
              callback: updateSetting, // Pass the update function
            ),
            TextField(
              controller: txtLong, // Controller for long break input
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center, // Center text
              keyboardType: TextInputType.number, // Numeric input
            ),
            // Increment button for long break time
            SettingButton(
              color: Color(0xff009688),
              text: "+",
              value: 1,
              setting: LONGBREAK,
              callback: updateSetting, // Pass the update function
            ),
          ],
        ),
      ),
    );
  }

  // Asynchronously read settings from SharedPreferences
  Future<void> readSettings() async {
    prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences
    setState(() {
      // Load the saved settings or use default values if none are found
      workTime = prefs.getInt(WORKTIME) ?? 30;
      shortBreak = prefs.getInt(SHORTBREAK) ?? 5;
      longBreak = prefs.getInt(LONGBREAK) ?? 20;

      // Set the text field values
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  // Update the settings based on button presses
  void updateSetting(String? setting, int value) {
    int newValue; // Variable to hold the new value
    switch (setting) {
      case WORKTIME:
        newValue = workTime + value; // Calculate new work time
        if (newValue >= 1 && newValue <= 180) {
          // Check if the new value is within valid range
          setState(() {
            workTime = newValue; // Update work time
            txtWork.text = newValue.toString(); // Update text field
          });
          prefs.setInt(WORKTIME, newValue); // Save the updated work time
        }
        break;
      case SHORTBREAK:
        newValue = shortBreak + value; // Calculate new short break time
        if (newValue >= 1 && newValue <= 120) {
          // Check if the new value is within valid range
          setState(() {
            shortBreak = newValue; // Update short break time
            txtShort.text = newValue.toString(); // Update text field
          });
          prefs.setInt(SHORTBREAK, newValue); // Save the updated short break time
        }
        break;
      case LONGBREAK:
        newValue = longBreak + value; // Calculate new long break time
        if (newValue >= 1 && newValue <= 180) {
          // Check if the new value is within valid range
          setState(() {
            longBreak = newValue; // Update long break time
            txtLong.text = newValue.toString(); // Update text field
          });
          prefs.setInt(LONGBREAK, newValue); // Save the updated long break time
        }
        break;
    }
  }
}
