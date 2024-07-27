import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/screens/transactions/choose_recipient_screen.dart';

class ServiceListing extends StatelessWidget {
  const ServiceListing({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Center(
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 0,
            runSpacing: 0,
            children: [
              _ServiceButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChooseRecipientScreen.routeName);
                  },
                  text: l.transfer,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffdee5ff)),
                      child: Image.asset('assets/images/icons/home/User.png'))),
              _ServiceButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  text: l.payment,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xfffff8d2)),
                      child: Image.asset('assets/images/icons/home/Cart.png'))),
              _ServiceButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  text: l.credit,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffe4f7ff)),
                      child:
                          Image.asset('assets/images/icons/home/Phone.png'))),
              _ServiceButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  text: l.bank,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xfffff0f0)),
                      child: Image.asset(
                          'assets/images/icons/home/Building.png'))),
              _ServiceButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  text: l.gifts,
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffe3ffdf)),
                      child: Image.asset('assets/images/icons/home/Gift.png')))
            ]),
      ),
    );
  }
}

class _ServiceButton extends StatelessWidget {
  final String text;
  final Widget child;
  final Function() onPressed;

  const _ServiceButton(
      {required this.text, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(width: 60, height: 60, child: child),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500),
            )
          ],
        ));
  }
}
