import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewNumberScreen extends StatefulWidget {
  const NewNumberScreen({super.key});

  static const routeName = '/new-phone-number';

  @override
  State<NewNumberScreen> createState() => _NewNumberScreenState();
}

class _NewNumberScreenState extends State<NewNumberScreen> {
  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l.send_money)),
      body: const Placeholder(),
    );
  }
}
