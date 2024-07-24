import 'package:flutter/material.dart';
import 'package:waveapp/config/app.dart';
import 'package:waveapp/screens/home/history/transaction_item.dart';
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

  @override
  void initState() {
    super.initState();
    DataService.loadTransactions().then((data) {
      setState(() {
        _transactions = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: true,
                stretch: false,
                automaticallyImplyLeading: false,
                pinned: true,
                primary: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                expandedHeight: 80,
                collapsedHeight: 80,
                flexibleSpace: const FlexibleSpaceBar(
                  title: BalanceDisplayWidget(
                    balance: 16008,
                  ),
                )),
            SliverToBoxAdapter(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 100,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))))),
                  const HomeQrCode(),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: ServiceListing()),
            SliverToBoxAdapter(
              child: Container(
                color: const Color(0xfff0f0f0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              if (index < _transactions.length) {
                return TransactionItem(transaction: _transactions[index]);
              }
              return const SizedBox();
            }, childCount: AppConfig.maxHistoryItems))
          ],
        )));
  }
}
