import 'package:flutter/material.dart';
import 'package:waveapp/models/contact_model.dart';
import 'package:waveapp/screens/home/home_screen.dart';
import 'package:waveapp/utils/format.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/widgets/button.dart';

class CreditAmountFormScreen extends StatefulWidget {
  final ContactModel contact;

  const CreditAmountFormScreen({super.key, required this.contact});

  @override
  State<CreditAmountFormScreen> createState() => _CreditAmountFormScreenState();
}

class _CreditAmountFormScreenState extends State<CreditAmountFormScreen> {
  final _controller = TextEditingController();
  bool _disabled = true;

  void _formatAmount() {
    String text = _controller.text.replaceAll(' ', '');
    String formatted =
        text.isNotEmpty ? formatNumber(double.parse(text), replace: '.') : '';

    _controller.removeListener(_formatAmount);
    _controller.value = _controller.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    _controller.addListener(_formatAmount);
  }

  void _checkDisabled() {
    final text = _controller.text.replaceAll(' ', '');
    final amount = text.isNotEmpty ? int.parse(text) : 0;

    setState(() {
      _disabled = amount < 500;
    });
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
    final contact = widget.contact;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.buy_credit),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xffd5d5d5),
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          'assets/images/icons/contacts/avatar.png',
                          width: 28,
                          height: 28,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (contact.phoneNumber.isNotEmpty)
                          Text(contact.phoneNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black54))
                      ],
                    )),
                  ],
                )),
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
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName, (route) => false);
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
