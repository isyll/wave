import 'package:flutter/material.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth_screen.dart';
import 'package:waveapp/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
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
      title: 'Wave by Ibrahima Sylla',
      home: const AuthScreen(),
      locale: Constants.locale,
      supportedLocales: Constants.supportedLocales,
    );
  }
}
