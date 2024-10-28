import 'dart:async';
import 'package:flutter/material.dart';
import './timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  // Timer settings with default values
  int work = 30;          // Work duration in minutes
  int shortBreak = 5;      // Short break duration in minutes
  int longBreak = 20;      // Long break duration in minutes

  // Variables to control timer and UI updates
  double _radius = 1;      // Progress radius for a circular timer
  bool isActive = true;    // Flag to indicate if the timer is active
  late Timer timer;        // The main timer instance
  late Duration _time;     // Current countdown time
  late Duration _fulltime; // Full duration set when timer starts

  // Method to start the work timer
  Future<void> startWork() async {
    await readSettings();                 // Load settings from SharedPreferences
    _radius = 1;                           // Reset radius to full circle
    _time = Duration(minutes: work, seconds: 0); // Set timer to work duration
    _fulltime = _time;                     // Store full time for progress calculation
    isActive = true;                       // Activate the timer
  }

  // Method to stop the timer
  void stopTimer() {
    isActive = false;                      // Deactivate the timer
  }

  // Method to restart the timer if it has time left
  void startTimer() {
    if (_time.inSeconds > 0) {             // Check if there’s time remaining
      isActive = true;                     // Reactivate the timer
    }
  }

  // Method to start a break timer, either short or long
  void startBreak(bool isShort) {
    _radius = 1;                           // Reset radius to full circle
    _time = Duration(
      minutes: isShort ? shortBreak : longBreak, // Choose break time
      seconds: 0,
    );
    _fulltime = _time;                     // Store full time for progress calculation
  }

  // Method to format remaining time as MM:SS string
  String returnTime(Duration t) {
    // Format minutes with leading zero if needed
    String minutes = t.inMinutes < 10 ? '0${t.inMinutes}' : t.inMinutes.toString();

    // Calculate remaining seconds and format with leading zero if needed
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = numSeconds < 10 ? '0$numSeconds' : numSeconds.toString();

    return "$minutes:$seconds";            // Return formatted time string
  }

  // Stream that provides timer updates every second
  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      if (isActive) {
        _time -= const Duration(seconds: 1);      // Subtract one second
        _radius = _time.inSeconds / _fulltime.inSeconds; // Update progress radius

        if (_time.inSeconds <= 0) {         // Stop timer if time is up
          isActive = false;
        }
      }

      String time = returnTime(_time);      // Format time for display
      return TimerModel(time, _radius);     // Return updated time and radius
    });
  }

  // Method to read settings from SharedPreferences
  Future<void> readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve saved work, shortBreak, and longBreak times, or use defaults
    work = prefs.getInt('workTime') ?? 30;
    shortBreak = prefs.getInt('shortBreak') ?? 5;
    longBreak = prefs.getInt('longBreak') ?? 20;
  }
}
