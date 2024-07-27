import 'package:flutter_contacts/contact.dart';
import 'package:waveapp/utils/number.dart';

class ContactModel {
  const ContactModel({required this.name, required this.phoneNumber});

  final String name;
  final String phoneNumber;

  static List<ContactModel> fromContacts(List<Contact> contacts) {
    final List<ContactModel> result = [];

    for (var contact in contacts) {
      final name = contact.displayName;
      final phones = contact.phones.toList();

      if (phones.isNotEmpty) {
        for (var phone in contact.phones) {
          result.add(
              ContactModel(name: name, phoneNumber: phone.normalizedNumber));
        }
      } else {
        result
            .add(ContactModel(name: name, phoneNumber: generatePhoneNumber()));
      }
    }

    return result;
  }
}
