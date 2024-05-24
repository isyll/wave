import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth_screen.dart';
import 'package:waveapp/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      title: 'Wave',
      home: const AuthScreen(),
      locale: Constants.locale,
      supportedLocales: Constants.supportedLocales,
    );
  }
}
