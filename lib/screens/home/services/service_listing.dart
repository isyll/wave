import 'package:flutter/material.dart';

class ServiceListing extends StatelessWidget {
  const ServiceListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(5, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 32, height: 32, child: Placeholder()),
            Text(
              'Item #$index',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500),
            )
          ],
        );
      }),
    );
  }
}
