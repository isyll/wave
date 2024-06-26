import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/widgets/pin_code.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  final logoPath = 'assets/images/wave-logo-removebg.png';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String pinCode = '';
  int pinLength = 4;

  @override
  void initState() {
    super.initState();
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
                  width: 120,
                  widget.logoPath,
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
                PinCode(onCompleted: (code) {}, pinLength: 4)
              ],
            ),
          )
        ],
      ),
    ));
  }
}
