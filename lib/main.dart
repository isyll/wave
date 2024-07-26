import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth/auth_screen.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/qr_code/qr_code_screen.dart';
import 'package:waveapp/screens/settings/settings_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen.dart';
import 'package:waveapp/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final routeObserver = RouteObserver<PageRoute>();
  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 300),
      invalidateSessionForUserInactivity: const Duration(seconds: 300));

  late StreamSubscription sessionConfigStreamSubscription;

  @override
  void initState() {
    super.initState();

    sessionConfigStreamSubscription =
        sessionConfig.stream.listen((SessionTimeoutState timeout) {
      if (timeout == SessionTimeoutState.userInactivityTimeout) {
        navigatorKey.currentState!.pushReplacementNamed(AuthScreen.routeName);
      } else if (timeout == SessionTimeoutState.appFocusTimeout) {
        navigatorKey.currentState!.pushReplacementNamed(AuthScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        navigatorObservers: [routeObserver],
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
        initialRoute: AuthScreen.routeName,
        locale: Constants.locale,
        supportedLocales: Constants.supportedLocales,
        routes: {
          AuthScreen.routeName: (context) => const AuthScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
          QrCodeScreen.routeName: (context) => const QrCodeScreen(),
          TransferScreen.routeName: (context) => const TransferScreen(),
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sessionConfigStreamSubscription.cancel();
  }
}
