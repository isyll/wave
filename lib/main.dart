import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:waveapp/config/app.dart';
import 'package:waveapp/config/constants.dart';
import 'package:waveapp/screens/auth/auth_screen.dart';
import 'package:waveapp/screens/banking/bank_list_screen.dart';
import 'package:waveapp/screens/credit/select_credit_recipient_screen.dart';
import 'package:waveapp/screens/gitfts/gifts_dashboard.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/qr_code/qr_code_screen.dart';
import 'package:waveapp/screens/settings/settings_screen.dart';
import 'package:waveapp/screens/transactions/choose_recipient_screen.dart';
import 'package:waveapp/screens/transactions/details/transaction_details_screen.dart';
import 'package:waveapp/screens/transactions/history/history_screen.dart';
import 'package:waveapp/screens/transactions/new_number_screen.dart';
import 'package:waveapp/screens/transactions/payment/payment_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen.dart';
import 'package:waveapp/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/utils/globals.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus:
          const Duration(seconds: AppConfig.appLostFocusTimeout),
      invalidateSessionForUserInactivity:
          const Duration(seconds: AppConfig.userInactivityTimeout));

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
      child: GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.25),
      overlayWidgetBuilder: (_) => Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.black.withOpacity(0.5),
          size: 50.0,
        ),
      ),
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
            ChooseRecipientScreen.routeName: (context) => const ChooseRecipientScreen(),
            NewNumberScreen.routeName: (context) => const NewNumberScreen(),
            HistoryScreen.routeName: (context) => const HistoryScreen(),
            TransactionDetailsScreen.routeName: (context) => const TransactionDetailsScreen(),
            PaymentScreen.routeName: (context) => const PaymentScreen(),
            BankListScreen.routeName: (context) => const BankListScreen(),
            SelectCreditRecipientScreen.routeName: (context) => const SelectCreditRecipientScreen(),
            GiftsDashboard.routeName: (context) => const GiftsDashboard()
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sessionConfigStreamSubscription.cancel();
  }
}
