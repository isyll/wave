import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/settings/types/settings_item.dart';
import 'package:waveapp/screens/settings/widgets/settings_group.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final groups = data(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(l.settings), backgroundColor: Colors.grey.shade100),
      body: ListView(children: groups),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

List<SettingsGroup> data(BuildContext context) {
  final l = AppLocalizations.of(context)!;

  return [
    SettingsGroup(
      title: l.share,
      items: [
        SettingsItem(
            icon: const Icon(
              Icons.share,
              size: 40,
            ),
            title: l.invite_friend,
            action: const SettingsScreen()),
        SettingsItem(
            icon: Image.asset(
              'assets/images/icons/settings/blink.png',
              width: 40,
              height: 40,
            ),
            title: l.promo_code,
            action: const SettingsScreen())
      ],
    )
  ];
}
