import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 10,
              children: [
                _CategoryButtonData(
                    title: l.invoices,
                    icon: Image.asset(
                      'assets/images/icons/payments/Light.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.restoration,
                    icon: Image.asset(
                      'assets/images/icons/payments/Hamburger.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.shopping,
                    icon: Image.asset(
                      'assets/images/icons/payments/Shopping.png',
                      width: 40,
                    )),
                _CategoryButtonData(
                    title: l.tourism,
                    icon: Image.asset(
                      'assets/images/icons/payments/Tourism.png',
                      width: 40,
                    ))
              ]
                  .map((data) => TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(LinearBorder.none),
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        child: Column(
                          children: [
                            data.icon,
                            Text(data.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    color: Colors.black))
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          ...List.generate(
              100,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Item #$index',
                    ),
                  ))
        ],
      ),
    ));
  }
}

class _CategoryButtonData {
  final String title;
  final Widget icon;

  const _CategoryButtonData({required this.title, required this.icon});
}
