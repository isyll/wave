import 'package:flutter/material.dart';
import 'package:waveapp/models/country_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountrySelector extends StatefulWidget {
  final Function(String countryCode) onChange;
  static final countries = [
    const CountryModel(name: 'Sénégal', code: 'SN', indicator: '+221'),
    const CountryModel(name: 'Burkina Faso', code: 'BF', indicator: '+226'),
    const CountryModel(name: 'Côte d\'Ivoire', code: 'CI', indicator: '+225'),
    const CountryModel(name: 'Mali', code: 'ML', indicator: '+223'),
  ];
  final String defaultCountryCode;

  const CountrySelector(
      {super.key, required this.onChange, this.defaultCountryCode = 'SN'});

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<CountryModel> get countries => CountrySelector.countries;
  CountryModel? _selectedCountry;

  Widget countryFlag(String code) {
    final path = 'assets/images/country_flags/$code.png';

    return Image.asset(
      path,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    _selectedCountry = _selectedCountry ??
        countries
            .where((country) => country.code == widget.defaultCountryCode)
            .first;
    String selectedOption = _selectedCountry!.code;

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) =>
                StatefulBuilder(builder: (context, setAlertState) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(16),
                    contentPadding: const EdgeInsets.all(8),
                    title: Text(l.select_your_country),
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: countries
                          .map((country) => ListTile(
                              leading: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  countryFlag(country.code),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    country.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    country.indicator,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 12,
                                            color: Colors.black45),
                                  )
                                ],
                              ),
                              trailing: Radio<String>(
                                value: country.code,
                                groupValue: selectedOption,
                                onChanged: (countryCode) {
                                  setAlertState(() {
                                    selectedOption = countryCode!;
                                  });
                                  setState(() {
                                    _selectedCountry = countries
                                        .where(
                                            (item) => item.code == countryCode)
                                        .first;
                                  });
                                  widget.onChange(countryCode!);
                                },
                              )))
                          .toList(),
                    ),
                  );
                }));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            countryFlag(_selectedCountry!.code),
            const SizedBox(
              width: 4,
            ),
            Text(_selectedCountry!.indicator),
            const SizedBox(
              width: 4,
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),
    );
  }
}
