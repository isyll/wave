import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          pinned: true,
          snap: true,
          floating: true,
          title: Text(l.payment),
          bottom: AppBar(
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            automaticallyImplyLeading: false,
            title: TextField(
              decoration: InputDecoration(
                  hintText: l.search_by_name,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 32,
                  ),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black26)),
                  enabledBorder: const OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(width: 1, color: Colors.black26))),
            ),
          ),
        ),
      ],
      body: ListView.builder(
        itemBuilder: (context, index) => Text('Item #$index'),
        itemCount: 100,
      ),
    ));
  }
}
