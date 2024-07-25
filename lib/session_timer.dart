import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waveapp/screens/auth/auth_screen.dart';

class SessionTimer {
  late Timer timer;
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      timedOut();
    });
  }

  void userActivityDetected() {
    if (!timer.isActive) {
      timer.cancel();
      startTimer();
    }
  }

  Future<void> timedOut() async {
    timer.cancel();
    _navigator.pushNamed(AuthScreen.routeName);
  }
}
