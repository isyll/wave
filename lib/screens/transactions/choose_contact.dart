import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseContact extends StatefulWidget {
  const ChooseContact({super.key});
  static const routeName = '/recipient';

  @override
  State<ChooseContact> createState() => _ChooseContactState();
}

class _ChooseContactState extends State<ChooseContact> {
  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l.send_money)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: l.transfer_to),
            ),
            const SizedBox(
              height: 14,
            ),
            ...[
              [Icons.add_circle, l.add_new_phone_number],
              [Icons.qr_code_scanner_sharp, l.scan_for_send]
            ].asMap().entries.map((element) {
              final key = element.key;
              final value = element.value;
              final icon = value[0] as IconData;
              final text = value[1] as String;

              return Flexible(
                child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(key == 0
                            ? const EdgeInsets.only(bottom: 10)
                            : EdgeInsets.zero)),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 60,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              );
            }),
          ],
        ),
      ),
    );
  }
}
