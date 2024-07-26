import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  static const routeName = '/transfer';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.transfer_money),
      ),
      body: const Placeholder(),
    );
  }
}
