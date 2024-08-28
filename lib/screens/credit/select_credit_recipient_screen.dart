import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:waveapp/models/contact_model.dart';
import 'package:waveapp/screens/credit/credit_amount_form_screen.dart';
import 'package:waveapp/utils/common.dart';

class SelectCreditRecipientScreen extends StatefulWidget {
  static String routeName = '/credit';

  const SelectCreditRecipientScreen({super.key});

  @override
  State<SelectCreditRecipientScreen> createState() =>
      _SelectCreditRecipientScreenState();
}

class _SelectCreditRecipientScreenState
    extends State<SelectCreditRecipientScreen> {
  bool _permissionDenied = false;
  List<ContactModel> _contacts = [];
  List<ContactModel> _allContacts = [];
  final _controller = TextEditingController();
  late FocusNode _focusNode;

  Future<void> _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      _allContacts =
          ContactModel.fromContacts(await FlutterContacts.getContacts());
      setState(() => _contacts = _allContacts);
    }
  }

  void _filterContacts() {
    final searchValue = _controller.text;

    if (searchValue.isNotEmpty) {
      setState(() {
        _contacts = _allContacts
            .where((data) =>
                data.name.toLowerCase().contains(searchValue) ||
                data.phoneNumber.replaceAll(' ', '').contains(searchValue))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller.addListener(_filterContacts);
    context.loaderOverlay.show();
    _fetchContacts().then((_) {
      if (mounted) {
        context.loaderOverlay.hide();
        _focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = getApplocalizations(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(l.buy_credit),
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(labelText: l.transfer_to),
                ),
              ))),
      body: !_permissionDenied
          ? ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];

                return Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(left: 16, right: 16, top: 20)
                      : const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              index < _contacts.length - 1
                                  ? const EdgeInsets.only(bottom: 16)
                                  : EdgeInsets.zero)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CreditAmountFormScreen(contact: contact)));
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
                      )),
                );
              })
          : null,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_filterContacts);
    _controller.dispose();
    super.dispose();
  }
}
