import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/utils/misc.dart';
import 'package:waveapp/widgets/pin_code.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String pinCode = '';
  final pinLength = 4;
  final routeArgs =
      const HomeScreenArguments(previousRoute: AuthScreen.routeName);

  void onCompleted(int code) {
    context.loaderOverlay.show();
    tick(1000).then((_) {
      if (mounted) {
        context.loaderOverlay.hide();
        Navigator.pushReplacementNamed(context, HomeScreen.routeName,
            arguments: routeArgs);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
        body: SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/wave-logo-removebg.png',
                  width: 120,
                ),
                const SizedBox(height: 60),
                SizedBox(
                    width: 300,
                    child: Text(
                      textAlign: TextAlign.center,
                      l.code_is_required,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                    )),
                const SizedBox(height: 100),
                PinCode(onCompleted: onCompleted, pinLength: 4)
              ],
            ),
          )
        ],
      ),
    ));
  }
}
