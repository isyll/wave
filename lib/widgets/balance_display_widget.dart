import 'package:flutter/material.dart';
import 'package:waveapp/utils/format.dart';

class BalanceDisplayWidget extends StatefulWidget {
  final double balance;
  final bool hide;
  final int hiddenLength;

  const BalanceDisplayWidget(
      {super.key,
      required this.balance,
      this.hide = true,
      this.hiddenLength = 8});

  @override
  State<BalanceDisplayWidget> createState() => _BalanceDisplayWidgetState();
}

class _BalanceDisplayWidgetState extends State<BalanceDisplayWidget> {
  late bool hidden;

  Widget get ball => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.onPrimary),
        height: 12,
        width: 12,
      );

  Widget get balanceDisplay {
    final formattedBalance = formatNumber(widget.balance);

    return hidden
        ? Expanded(
            flex: 0,
            child: Row(
              children: List.generate(widget.hiddenLength, (_) => ball),
            ))
        : Text(
            '${formattedBalance}F',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          );
  }

  @override
  void initState() {
    super.initState();
    hidden = widget.hide;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            setState(() {
              hidden = !hidden;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              balanceDisplay,
              const SizedBox(
                width: 5,
              ),
              Icon(
                hidden ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.surface,
                size: 28,
              )
            ],
          )),
    );
  }
}
