import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:waveapp/screens/auth_screen.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
