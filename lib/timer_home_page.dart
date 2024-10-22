import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  const TimerHomePage({super.key});

  void emptyMethod() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer',
        style:TextStyle(color:Colors.white),),
        backgroundColor: Colors.blueGrey,
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
                    onPressed: emptyMethod,
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
                    onPressed: emptyMethod,
                    size: double.maxFinite,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: CircularPercentIndicator(
               radius: availableWidth/3,
                lineWidth: 10,
                percent: 1,
                center: Text('30:00',style: Theme.of(context).textTheme.displayMedium,),
                progressColor: const Color(0xff009688),
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
                    onPressed: emptyMethod,
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
                    onPressed: emptyMethod,
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
