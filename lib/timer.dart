import 'dart:async';
import 'package:flutter/material.dart';
import './timermodel.dart';

class CountDownTimer {
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  // Initialize fields properly
  double _radius = 1;
  bool isActive = true;
  late Timer timer;  // Initialized later when used
  late Duration _time;  // Initialized in `startWork()`
  late Duration _fulltime;  // Initialized in `startWork()`

  // Method to start the work timer
  void startWork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);  // Reset to the work time
    _fulltime = _time;  // Set full time
    isActive = true;  // Timer starts active
  }

  void stopTimer(){
    this.isActive = false;
  }

  void startTimer(){
   if (_time.inSeconds > 0) {
     this.isActive = true;
   }
  }

  //method for shortbreak and longbreak
  void startBreak(bool isShort){
    _radius =1 ;
    _time = Duration(
        minutes: (isShort) ? shortBreak : longBreak,
        seconds:0);
    _fulltime =_time;
  }
  // Method to format time as a string
  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10) ? '0' + t.inMinutes.toString() : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    return "$minutes:$seconds";
  }

  // Stream that provides timer updates
  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      if (isActive) {
        _time = _time - const Duration(seconds: 1);  // Subtract one second
        _radius = _time.inSeconds / _fulltime.inSeconds;  // Update radius

        if (_time.inSeconds <= 0) {
          isActive = false;  // Deactivate timer when it reaches 0
        }
      }

      String time = returnTime(_time);  // Format time
      return TimerModel(time, _radius);  // Return updated timer model
    });
  }
}
