import 'package:flutter/material.dart';
import 'package:waveapp/screens/transactions/details/transaction_details_arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/services/transactions/transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as TransactionDetailsArguments;
    final transaction = args.transaction;

    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(backgroundColor: const Color(0xfff3f4f6)),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.formattedAmount,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 28),
                        ),
                        Text(transaction.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 16))
                      ],
                    )),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xffd9e2f9),
                        borderRadius: BorderRadius.circular(100)),
                    child: Image.asset(
                      'assets/images/icons/transactions/person.png',
                      width: 50,
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
              flex: 2, child: Center(child: _TransactionInfos(transaction))),
          const Flexible(flex: 3, child: SizedBox())
        ],
      )),
    );
  }
}

class _TransactionInfos extends StatelessWidget {
  final Transaction transaction;

  const _TransactionInfos(this.transaction);

  Widget labelText(String text, BuildContext context) => Text(text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.black, fontSize: 18));

  Widget valueText(String text, BuildContext context) => Text(text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: const Color(0xff8a8a8a), fontSize: 18));

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    const spacer = SizedBox(
      height: 10,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.received_amount, context),
                valueText(transaction.formattedAmount, context)
              ],
            ),
          ),
          spacer,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.fees, context),
                valueText(transaction.formattedFees, context)
              ],
            ),
          ),
          spacer,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.status, context),
                valueText(transaction.statusToString(context), context)
              ],
            ),
          ),
          spacer,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.date_and_time, context),
                valueText(
                    transaction.formatDate(currentLocale.languageCode), context)
              ],
            ),
          ),
          spacer,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.new_balance, context),
                valueText(transaction.formattedNewBalance, context)
              ],
            ),
          ),
          spacer,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelText(l.transaction_id, context),
                valueText(transaction.id, context)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
