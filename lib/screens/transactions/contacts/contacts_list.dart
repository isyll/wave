import 'package:flutter/material.dart';
import 'package:waveapp/models/contact_model.dart';

class ContactsList {
  final BuildContext context;
  final List<ContactModel> contacts;
  final Function(ContactModel contact) onChoose;
  final String labelText;

  const ContactsList(
      {required this.context,
      required this.labelText,
      required this.contacts,
      required this.onChoose});

  List<Widget> get() {
    return [
      const SizedBox(
        height: 20,
      ),
      Text(
        labelText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
      ),
      const SizedBox(
        height: 16,
      ),
      ...contacts.asMap().entries.map((entry) {
        final key = entry.key;
        final contact = entry.value;

        return TextButton(
            style: ButtonStyle(
                padding: WidgetStatePropertyAll(key < contacts.length - 1
                    ? const EdgeInsets.only(bottom: 16)
                    : EdgeInsets.zero)),
            onPressed: () {
              onChoose(contact);
            },
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
            ));
      })
    ];
  }
}
