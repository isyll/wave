import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:waveapp/screens/home/history/transaction_item.dart';
import 'package:waveapp/screens/transactions/details/transaction_details_arguments.dart';
import 'package:waveapp/screens/transactions/details/transaction_details_screen.dart';
import 'package:waveapp/services/data_service.dart';
import 'package:waveapp/services/transactions/transaction.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Transaction> transactions = [];
  List<Transaction> allTransactions = [];
  bool onlyTransfers = false;
  bool onlyInvoices = false;
  final searchController = TextEditingController();

  void loadTransactions() {
    context.loaderOverlay.show();
    Future.delayed(const Duration(milliseconds: 1650), () async {
      allTransactions = await DataService.loadTransactions();

      setState(() {
        transactions = allTransactions;
        // context.loaderOverlay.hide();
      });
    });
  }

  void filterTransactions() {
    final text = searchController.text.toLowerCase().trim();

    if (text.isNotEmpty) {
      setState(() {
        transactions = allTransactions
            .where(
                (transaction) => transaction.title.toLowerCase().contains(text))
            .toList();
      });
    } else {
      setState(() {
        transactions = allTransactions;
      });
    }
  }

  Widget textButton(String text, IconData icon) => TextButton(
      style: const ButtonStyle(
          padding:
              WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8.0)),
          backgroundColor: WidgetStatePropertyAll(Color(0xffe5e5e5))),
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff666666),
            size: 26,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: const Color(0xff666666)),
          )
        ],
      ));

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterTransactions);
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.25),
      overlayWidgetBuilder: (_) => Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.black.withOpacity(0.5),
          size: 50.0,
        ),
      ),
      child: Scaffold(
          backgroundColor: const Color(0xfff3f4f6),
          appBar: AppBar(
            backgroundColor: const Color(0xfff3f4f6),
            surfaceTintColor: const Color(0xfff3f4f6),
            title: Text(l.transactions),
          ),
          body: Column(
            children: [
              Container(
                color: const Color(0xfff3f4f6),
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: const Icon(Icons.search),
                      labelText: l.search,
                      filled: true,
                      fillColor: const Color(0xffe5e5e5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
              Container(
                color: const Color(0xfff3f4f6),
                padding: const EdgeInsets.all(12.0),
                child: Row(children: [
                  textButton(l.transfers, Icons.person),
                  const SizedBox(width: 16),
                  textButton(l.invoices, Icons.receipt),
                ]),
              ),
              if (transactions.isNotEmpty)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              TransactionDetailsScreen.routeName,
                              arguments: TransactionDetailsArguments(
                                  transaction: transactions[index]));
                        },
                        child: TransactionItem(
                          transaction: transactions[index],
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: index == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))
                                  : index == transactions.length - 1
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))
                                      : null),
                        ),
                      ),
                      itemCount: transactions.length,
                    ),
                  ),
                )
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(filterTransactions);
    searchController.dispose();
  }
}
