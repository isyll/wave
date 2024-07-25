import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waveapp/screens/home/home_screen.dart';
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
  int pinLength = 4;

  void onCompleted(int code) {
    context.loaderOverlay.show();
    Future.delayed(const Duration(milliseconds: 1000), () {
      context.loaderOverlay.hide();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.25),
      overlayWidgetBuilder: (_) {
        return Center(
          child: SpinKitRing(
            lineWidth: 4,
            color: Colors.black.withOpacity(0.5),
            size: 50.0,
          ),
        );
      },
      child: Scaffold(
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
      )),
    );
  }
}
