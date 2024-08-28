import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:waveapp/screens/banking/types/bank_item.dart';
import 'package:waveapp/screens/identity_check/identity_check_screen.dart';
import 'package:waveapp/utils/misc.dart';

class BankItemWidget extends StatelessWidget {
  final BankItem bankItem;

  const BankItemWidget({super.key, required this.bankItem});

  void _showDialog(BuildContext context) {
    context.loaderOverlay.show();

    tick(800).then((_) {
      if (context.mounted) {
        context.loaderOverlay.hide();

      showDialog(
          context: context,
          builder: (context) =>
              StatefulBuilder(builder: (context, setAlertState) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(24),
                  contentPadding: const EdgeInsets.all(24),
                  title: const Text('Erreur'),
                  content: const Text(
                      "Vérifier votre pièce d'identité pour accéder à la fonction banque"),
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'ANNULER',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(IdentityCheckScreen.routeName);
                        },
                        child: Text(
                          'VERIFICATION IDENTITE',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        )),
                  ],
                );
              }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(context),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(children: [
          Container(
            height: 64,
            width: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: bankItem.bgColor,
                borderRadius: BorderRadius.circular(8)),
            child: bankItem.img,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              bankItem.name,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
