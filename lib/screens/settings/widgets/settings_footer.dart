import 'package:flutter/material.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
    final tbTheme = ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.onSurface.withOpacity(0.08)),
      foregroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
      textStyle: WidgetStatePropertyAll(
          textTheme.copyWith(fontWeight: FontWeight.normal)),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 26,
          child: Text(
            'wave digital finance',
            style: textTheme,
          ),
        ),
        SizedBox(
          height: 26,
          child: Text(
            'version 24.07.12-429016',
            style: textTheme,
          ),
        ),
        SizedBox(
          height: 26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                style: tbTheme,
                child: Text(
                  'Conditions générales',
                  style: textTheme,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '|',
                  style: textTheme,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: tbTheme,
                child: Text(
                  'Avis de confidentialité',
                  style: textTheme,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 26,
          child: TextButton(
            onPressed: () {},
            style: tbTheme,
            child: Text('Fermer mon compte Wave', style: textTheme),
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}
