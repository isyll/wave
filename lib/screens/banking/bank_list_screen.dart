import 'package:flutter/material.dart';

import 'package:waveapp/screens/banking/types/bank_item.dart';
import 'package:waveapp/screens/banking/widgets/bank_item_widget.dart';
import 'package:waveapp/widgets/prefix_search_widget.dart';

class BankListScreen extends StatefulWidget {
  static String routeName = '/banks';

  const BankListScreen({super.key});

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  BankType? selectedType;
  final _controller = TextEditingController();
  late List<BankItem> _bankItems;

  List<BankItem> _filterBanksByType(BankType type) =>
      _bankItems.where((bank) => bank.type == type).toList();

  void _filterBanks() {
    final text = _controller.text.trim().toLowerCase();

    setState(() {
      _bankItems = bankItems
          .where((bank) => bank.name.toLowerCase().contains(text))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _bankItems = bankItems;
    _controller.addListener(_filterBanks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        title: const Text('Lier votre banque ou MFI'),
        backgroundColor: const Color(0xfff3f4f6),
        surfaceTintColor: const Color(0xfff3f4f6),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: PrefixSearchField(
                prefix: null,
                controller: _controller,
                hintText: 'Rechercher par nom',
              )),
          Container(
            padding: const EdgeInsets.all(10),
            height: 80,
            child: Row(
              children: [
                _TabSwitcher(
                  onPressed: () {
                    setState(() {
                      selectedType =
                          selectedType == BankType.bank ? null : BankType.bank;
                    });
                  },
                  selected: selectedType == BankType.bank,
                  label: 'Banque',
                  icon: Icons.home_outlined,
                ),
                const SizedBox(
                  width: 12,
                ),
                _TabSwitcher(
                    onPressed: () {
                      setState(() {
                        selectedType =
                            selectedType == BankType.mfi ? null : BankType.mfi;
                      });
                    },
                    selected: selectedType == BankType.mfi,
                    label: 'MFI',
                    icon: Icons.attach_money),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView(
            children: [
              if (selectedType == null || selectedType == BankType.bank)
                _BankGroup(
                    label: 'Banques', items: _filterBanksByType(BankType.bank)),
              const SizedBox(
                height: 32,
              ),
              if (selectedType == null || selectedType == BankType.mfi)
                _BankGroup(
                    label: 'MFI', items: _filterBanksByType(BankType.mfi)),
            ],
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.addListener(_filterBanks);
    _controller.dispose();
    super.dispose();
  }
}

class _TabSwitcher extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const _TabSwitcher({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
            backgroundColor: WidgetStatePropertyAll(
                Colors.black12.withOpacity(selected ? 0.32 : 0.08))),
        onPressed: onPressed,
        icon: Row(
          children: [
            Icon(icon),
            Text(label),
          ],
        ));
  }
}

class _BankGroup extends StatelessWidget {
  final String label;
  final List<BankItem> items;

  const _BankGroup({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12), bottom: Radius.circular(0))),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        ...items.map((bank) => BankItemWidget(bankItem: bank)),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(0), bottom: Radius.circular(12)))),
      ],
    );
  }
}
