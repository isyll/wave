import 'package:flutter/material.dart';
import 'package:waveapp/screens/settings/types/settings_item.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.title, required this.items});

  final String title;
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45)),
        ),
        const SizedBox(
          height: 14,
        ),
        ...items.asMap().entries.map((item) {
          final key = item.key;
          final value = item.value;

          if (key == 0) {
            return Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: _Setting(value),
            );
          } else if (key == items.length - 1) {
            return Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14))),
              child: _Setting(value),
            );
          }

          return _Setting(value);
        })
      ]),
    );
  }
}

class _Setting extends StatelessWidget {
  const _Setting(this.item);

  final SettingsItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          item.icon,
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                softWrap: true,
              ),
              if (item.subTitle != null) Text(item.subTitle!)
            ],
          ))
        ],
      ),
    );
  }
}
