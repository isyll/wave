import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionSearch extends StatelessWidget {
  const TransactionSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      color: Theme.of(context).colorScheme.surface,
      child: const _Button(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return TextButton(
      style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
          backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)))),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.search,
            style: const TextStyle(fontSize: 18),
          ),
          const Icon(Icons.search)
        ],
      ),
    );
  }
}
