import 'package:flutter/material.dart';
import 'package:productivity_timer/settings_screen.dart';
import 'package:productivity_timer/timer.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatefulWidget {
  TimerHomePage({super.key});

  @override
  State<TimerHomePage> createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  final CountDownTimer timer = CountDownTimer();

  void goToSettings(BuildContext context) {
    Navigator.push(
      context,MaterialPageRoute(builder: (context) => SettingsScreen())
    );
  }

  void emptyMethod(){}

  @override
  Widget build(BuildContext context) {
    timer.startWork();

    // Initialize an empty list to hold PopupMenuItems of type String.
    final List<PopupMenuItem<String>> menuItems = [];
// Add a PopupMenuItem to the list with a Text widget as the child and 'Settings' as its value.
    menuItems.add(
      PopupMenuItem(
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
          PopupMenuButton(itemBuilder: (BuildContext context){
            return menuItems.toList();
          },
            onSelected: (s){
            if(s == 'Settings'){
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
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: 'Work',
                      onPressed: emptyMethod,
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
                      onPressed: () => timer.startBreak(true),
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
                      onPressed: () => timer.startBreak(false),
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
                    builder: (BuildContextcontext, AsyncSnapshot snapshot) {
                      TimerModel timer = (snapshot.data == '00:00')
                          ? TimerModel('00:00', 1)
                          : snapshot.data;
                      return CircularPercentIndicator(
                        radius: availableWidth / 3,
                        lineWidth: 10,
                        percent: timer.percent,
                        center: Text(
                          '30:00',
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium,
                        ),
                        progressColor: const Color(0xff009688),
                      );
                    }),
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
                      onPressed: () => timer.stopTimer,
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
                      onPressed: () => timer.startTimer,
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
