import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/models/country_model.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen_arguments.dart';
import 'package:waveapp/utils/format.dart';
import 'package:waveapp/widgets/button.dart';
import 'package:waveapp/widgets/country_selector.dart';

class NewNumberScreen extends StatefulWidget {
  const NewNumberScreen({super.key});

  static const routeName = '/new-phone-number';

  @override
  State<NewNumberScreen> createState() => _NewNumberScreenState();
}

class _NewNumberScreenState extends State<NewNumberScreen> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  late CountryModel _selectedCountry;
  bool _disabled = true;

  void _checkDisabled() {
    setState(() {
      _disabled = _nameController.text.trim().isEmpty ||
          _phoneNumberController.text.isEmpty;
    });
  }

  void _onSubmit() {
    final indicator = _selectedCountry.indicator;
    final name = _nameController.text;
    final raw = '$indicator${_phoneNumberController.text}'.replaceAll(' ', '');
    final phone = formatPhoneNumber(raw);

    Navigator.of(context).pushNamed(TransferScreen.routeName,
        arguments: TransferScreenArguments(name: name, phoneNumber: phone));
  }

  void _formatPhoneNumber() {
    String text = _phoneNumberController.text;
    String formatted = _applyPhoneFormatting(text);

    _phoneNumberController.removeListener(_formatPhoneNumber);
    _phoneNumberController.value = _phoneNumberController.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    _phoneNumberController.addListener(_formatPhoneNumber);
  }

  String _applyPhoneFormatting(String text) {
    text = text.replaceAll(' ', '');

    if (text.length > 9) {
      text = text.substring(0, 9);
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5 || i == 7) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkDisabled);
    _phoneNumberController.addListener(_checkDisabled);
    _phoneNumberController.addListener(_formatPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l.send_money)),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(letterSpacing: 0, color: Colors.black87),
                        labelText: l.full_name,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                        )),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      CountrySelector(onChange: (countryCode) {
                        setState(() {
                          _selectedCountry = CountrySelector.countries
                              .where((item) => item.code == countryCode)
                              .first;
                        });
                      }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: '7X XXX XX XX',
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(color: Colors.black54))),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Button(
                text: l.transfer_send, onPressed: _disabled ? null : _onSubmit)
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.removeListener(_checkDisabled);
    _phoneNumberController.removeListener(_checkDisabled);
    _phoneNumberController.removeListener(_formatPhoneNumber);
    _nameController.dispose();
    _phoneNumberController.dispose();
  }
}
