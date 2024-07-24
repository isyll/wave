import 'package:flutter/material.dart';
import 'package:waveapp/screens/home/history/transaction_item.dart';
import 'package:waveapp/screens/home/history/transaction_search.dart';
import 'package:waveapp/screens/home/services/service_listing.dart';
import 'package:waveapp/services/data_service.dart';
import 'package:waveapp/services/transactions/transaction.dart';
import 'package:waveapp/widgets/balance_display_widget.dart';
import 'package:waveapp/screens/home/home_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Transaction> _transactions = [];

  Future<void> _loadTransactions() async {
    // Fake fetch delay
    return Future.delayed(const Duration(milliseconds: 650), () {
      DataService.loadTransactions().then((data) {
        setState(() {
          _transactions = data;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
            child: Stack(
          children: [
            Positioned.fill(
                top: 250,
                child: Container(color: Theme.of(context).colorScheme.surface)),
            NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                          leading: Icon(
                            Icons.settings,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 30,
                          ),
                          centerTitle: true,
                          stretch: true,
                          pinned: true,
                          floating: false,
                          snap: false,
                          automaticallyImplyLeading: false,
                          expandedHeight: 85,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          flexibleSpace: const FlexibleSpaceBar(
                            centerTitle: true,
                            expandedTitleScale: 1.2,
                            titlePadding: EdgeInsets.zero,
                            title: BalanceDisplayWidget(
                              balance: 16218,
                            ),
                          )),
                    ],
                body: RefreshIndicator(
                    onRefresh: _loadTransactions,
                    child: ListView(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned.fill(
                                top: 100,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24))))),
                            const HomeQrCode(),
                          ],
                        ),
                        const ServiceListing(),
                        Container(
                          color: const Color(0xfff0f0f0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 6.0),
                        ),
                        for (int i = 0; i < _transactions.length; i++)
                          TransactionItem(transaction: _transactions[i]),
                        const TransactionSearch(),
                        Container(
                          height: 500,
                        ),
                      ],
                    ))),
          ],
        )));
  }
}
