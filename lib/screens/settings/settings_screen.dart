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
            actionRoute: SettingsScreen.routeName),
        SettingsItem(
            icon: Image.asset(
              'assets/images/icons/settings/blink.png',
              width: 40,
              height: 40,
            ),
            title: l.promo_code,
            actionRoute: SettingsScreen.routeName)
      ],
    ),
    SettingsGroup(
      title: l.support,
      items: [
        SettingsItem(
            icon: const Icon(
              Icons.phone,
              size: 40,
            ),
            title: l.emergency_service,
            subTitle: l.open_until_10,
            actionRoute: SettingsScreen.routeName),
        SettingsItem(
            icon: const Icon(
              Icons.notes,
              size: 40,
            ),
            title: l.verify_limit,
            actionRoute: SettingsScreen.routeName),
        SettingsItem(
            icon: const Icon(
              Icons.location_on_rounded,
              size: 40,
            ),
            title: l.find_agents,
            actionRoute: SettingsScreen.routeName)
      ],
    ),
    SettingsGroup(
      title: l.security,
      items: [
        SettingsItem(
            icon: const Icon(
              Icons.phone_android,
              size: 40,
            ),
            title: l.connected_devices,
            actionRoute: SettingsScreen.routeName),
        SettingsItem(
            icon: const Icon(
              Icons.shield,
              size: 40,
            ),
            title: l.secret_code,
            actionRoute: SettingsScreen.routeName)
      ],
    ),
    SettingsGroup(
      items: [
        SettingsItem(
            icon: const Icon(
              Icons.logout,
              size: 40,
            ),
            title: l.disconnect,
            actionRoute: SettingsScreen.routeName)
      ],
    )
  ];
}
