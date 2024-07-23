import 'package:flutter/material.dart';
import 'package:waveapp/widgets/balance_display_widget.dart';
import 'package:waveapp/widgets/home_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const Center(
                    child: HomeQrCode()
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        )));
  }
}