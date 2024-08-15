import 'package:flutter/material.dart';

class IdentityCheckScreen extends StatefulWidget {
  static const routeName = '/identity-check';

  const IdentityCheckScreen({super.key});

  @override
  State<IdentityCheckScreen> createState() => _IdentityCheckScreenState();
}

class _IdentityCheckScreenState extends State<IdentityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f4f6),
          surfaceTintColor: const Color(0xfff3f4f6),
          title: const Text('Plafonds du compte'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plafonds actuels',
                style: TextStyle(color: Colors.black45, fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Column(
                    children: [
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  item.label,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                item.value,
                                style: const TextStyle(
                                    color: Colors.black45, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Rendez-vous chez un agent Wave muni de votre pièce'
                  "d'identité ou soumettez une photo de votre pièce"
                  'pour déplafonner votre compte',
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}

const items = [
  _Item(label: 'Solde maximum de votre compte', value: '200.000F'),
  _Item(label: 'Cumul mensuel maximum', value: '200.000F'),
  _Item(label: 'Cumul août restant autorisé', value: '200.000F'),
];

class _Item {
  final String label;
  final String value;

  const _Item({required this.label, required this.value});
}
