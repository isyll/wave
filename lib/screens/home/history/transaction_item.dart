import 'package:flutter/material.dart';
import 'package:waveapp/services/transactions/transaction.dart';
import 'package:waveapp/utils/format.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Decoration? decoration;

  const TransactionItem(
      {super.key, required this.transaction, this.decoration});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Transaction get transaction => widget.transaction;

  String get amount {
    final formatted = formatNumber(transaction.amount, replace: '.');
    final prefix = transaction.isLess ? '-' : '';

    return '$prefix$formatted F';
  }

  Widget text(String text) {
    return Text(
      transaction.title,
      softWrap: true,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 20),
    );
  }

//   List<Widget> get displayBriefs {
//     final briefs = transaction.extraDisplayBriefs;
//     return briefs.map((text) => _Text(text)).toList();
//   }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    return Container(
        decoration: widget.decoration ??
            BoxDecoration(color: Theme.of(context).colorScheme.surface),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    softWrap: true,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    transaction.formatDate(currentLocale.languageCode),
                    style: const TextStyle(
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ));
  }
}
