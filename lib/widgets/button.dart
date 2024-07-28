import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      width: double.infinity,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              alignment: Alignment.center,
              backgroundColor: WidgetStateProperty.resolveWith(
                  (Set<WidgetState> states) =>
                      states.contains(WidgetState.disabled)
                          ? const Color(0xffa1e7ff)
                          : Theme.of(context).colorScheme.secondary)),
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary, fontSize: 24),
          )),
    );
  }
}
