import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/models/contact_model.dart';
import 'package:waveapp/screens/qr_code/qr_code_screen.dart';
import 'package:waveapp/screens/transactions/contacts/contacts_list.dart';
import 'package:waveapp/screens/transactions/new_number_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen_arguments.dart';

class ChooseRecipientScreen extends StatefulWidget {
  const ChooseRecipientScreen({super.key});
  static const routeName = '/recipient';

  @override
  State<ChooseRecipientScreen> createState() => _ChooseRecipientScreenState();
}

class _ChooseRecipientScreenState extends State<ChooseRecipientScreen> {
  bool permissionDenied = false;
  List<ContactModel> contacts = [];
  List<ContactModel> allContacts = [];
  final searchController = TextEditingController();

  AppLocalizations get l => AppLocalizations.of(context)!;

  Future<void> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      allContacts =
          ContactModel.fromContacts(await FlutterContacts.getContacts());
      setState(() => contacts = allContacts);
    }
  }

  void filterContacts() {
    final text = searchController.text.toLowerCase().trim();

    if (text.isNotEmpty) {
      setState(() {
        contacts = allContacts
            .where((contact) => contact.name.toLowerCase().contains(text))
            .toList();
      });
    } else {
      setState(() {
        contacts = allContacts;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
    searchController.addListener(filterContacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l.send_money)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              TextField(
                controller: searchController,
                decoration: InputDecoration(labelText: l.transfer_to),
              ),
              const SizedBox(
                height: 14,
              ),
              ...[
                _ButtonData(
                    icon: Icons.add_circle,
                    text: l.add_new_phone_number,
                    route: NewNumberScreen.routeName),
                _ButtonData(
                    icon: Icons.qr_code_scanner_sharp,
                    text: l.scan_for_send,
                    route: QrCodeScreen.routeName)
              ].asMap().entries.map((element) {
                final key = element.key;
                final value = element.value;

                return TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(value.route);
                    },
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(key == 0
                            ? const EdgeInsets.only(bottom: 10)
                            : EdgeInsets.zero)),
                    child: Row(
                      children: [
                        Icon(
                          value.icon,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 60,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          value.text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ));
              }),
            ])),
            SliverList(
              delegate: SliverChildListDelegate(ContactsList(
                context: context,
                labelText: 'Favoris',
                contacts: contacts,
                onChoose: (contact) {
                  Navigator.of(context).pushNamed(TransferScreen.routeName,
                      arguments: TransferScreenArguments(
                          name: contact.name,
                          phoneNumber: contact.phoneNumber));
                },
              ).get()),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(filterContacts);
    searchController.dispose();
  }
}

class _ButtonData {
  final IconData icon;
  final String text;
  final String route;

  const _ButtonData(
      {required this.icon, required this.text, required this.route});
}
