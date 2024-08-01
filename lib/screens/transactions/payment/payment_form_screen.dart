import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waveapp/providers/transactions_provider.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/services/data_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/services/transactions/transaction_type.dart';
import 'package:waveapp/utils/format.dart';
import 'package:waveapp/utils/generate.dart';
import 'package:waveapp/widgets/button.dart';

class PaymentFormScreen extends StatefulWidget {
  final Company company;

  const PaymentFormScreen({super.key, required this.company});

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _controller = TextEditingController();
  bool _disabled = true;

  void _checkDisabled() {
    final value = _controller.text.replaceAll('.', '');
    final amount = value.isNotEmpty ? int.parse(value) : 0;

    setState(() {
      _disabled = amount < 500;
    });
  }

  void _formatAmount() {
    String text = _controller.text.replaceAll('.', '');
    String formatted =
        text.isNotEmpty ? formatNumber(double.parse(text), replace: '.') : '';

    _controller.removeListener(_formatAmount);
    _controller.value = _controller.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    _controller.addListener(_formatAmount);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkDisabled);
    _controller.addListener(_formatAmount);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.pay),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black26, width: 1))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: widget.company.bgColor,
                    ),
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      widget.company.imgAsset,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.company.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l.amount),
              autofocus: true,
            ),
            const Expanded(child: SizedBox()),
            Button(
                text: l.pay,
                onPressed: _disabled
                    ? null
                    : () {
                        final amount =
                            double.parse(_controller.text.replaceAll('.', ''));
                        Provider.of<TransactionsProvider>(context,
                                listen: false)
                            .add(generateTransaction(
                                title: widget.company.name,
                                amount: amount,
                                type: Transactiontype.payment));
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_checkDisabled);
    _controller.removeListener(_formatAmount);
    _controller.dispose();
    super.dispose();
  }
}
