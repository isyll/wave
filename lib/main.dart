import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth/auth_screen.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/settings/settings_screen.dart';
import 'package:waveapp/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( App());
  });
}

class App extends StatelessWidget {
   App({super.key});

  final navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 15),
        invalidateSessionForUserInactivity: const Duration(seconds: 15));

    sessionConfig.stream.listen((SessionTimeoutState timeout) {
      if (timeout == SessionTimeoutState.userInactivityTimeout) {
        navigatorKey.currentState!.pushReplacementNamed(AuthScreen.routeName);
      } else if (timeout == SessionTimeoutState.appFocusTimeout) {
        navigatorKey.currentState!.pushReplacementNamed(AuthScreen.routeName);
      }
    });

    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        title: 'Wave by Isyll',
        home: const AuthScreen(),
        locale: Constants.locale,
        supportedLocales: Constants.supportedLocales,
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen()
        },
      ),
    );
  }
}
