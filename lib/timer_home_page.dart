
import 'package:flutter/material.dart';
import 'package:productivity_timer/settings_screen.dart';
import 'package:productivity_timer/timer.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatefulWidget {
  const TimerHomePage({super.key});

  @override
  State<TimerHomePage> createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  final CountDownTimer timer = CountDownTimer();

  // Method to navigate to settings screen
  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {


    // Initialize an empty list to hold PopupMenuItems of type String.
    final List<PopupMenuItem<String>> menuItems = [];
    // Add a PopupMenuItem to the list for settings.
    menuItems.add(
      const PopupMenuItem(
        child: Text('Settings'), // The visible text in the popup menu
        value: 'Settings',       // The value associated with this menu item
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Work Timer',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              // Row of buttons for Work, Short Break, and Long Break
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: 'Work',
                      onPressed: () => timer.startWork, // Placeholder for work button action
                      size: double.maxFinite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff607D8B),
                      text: 'Short Break',
                      onPressed: () => timer.startBreak(true), // Start short break
                      size: double.maxFinite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff455a64),
                      text: 'Long Break',
                      onPressed: () => timer.startBreak(false), // Start long break
                      size: double.maxFinite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<TimerModel>(
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot<TimerModel> snapshot) {
                    // Handle the timer data coming from the stream
                    TimerModel timerModel = snapshot.data ?? TimerModel('00:00', 1); // Default if no data
                    return CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      radius: availableWidth / 3,
                      lineWidth: 10,
                      percent: timerModel.percent ?? 1, // Fallback to 1 if null
                      center: Text(
                        timerModel.timer ?? '00:00', // Use '00:00' if time is null
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      progressColor: const Color(0xff009688),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff212121),
                      text: 'Stop',
                      onPressed: () {
                        timer.stopTimer(); // Correctly call the stopTimer method
                      },
                      size: double.maxFinite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009968),
                      text: 'Restart',
                      onPressed: () {
                        timer.startWork(); // Restart the timer (consider passing user-defined time)
                      },
                      size: double.maxFinite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
