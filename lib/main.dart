import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth/auth_screen.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/settings/settings_screen.dart';
import 'package:waveapp/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const App());
  });
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
      title: 'Wave by Isyll',
      initialRoute: SettingsScreen.routeName,
      locale: Constants.locale,
      supportedLocales: Constants.supportedLocales,
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen()
      },
    );
  }
}
