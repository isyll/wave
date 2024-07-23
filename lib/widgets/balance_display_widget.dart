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

  Widget get ball {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onPrimary),
      height: 18,
      width: 18,
    );
  }

  @override
  void initState() {
    super.initState();
    hidden = widget.hide;
  }

  @override
  Widget build(BuildContext context) {
    final formattedBalance = formatNumber(widget.balance);

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
              hidden
                  ? Expanded(
                      flex: 0,
                      child: Row(
                        children:
                            List.generate(widget.hiddenLength, (_) => ball),
                      ))
                  : Text(
                      '${formattedBalance}F',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                hidden ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.surface,
                size: 38,
              )
            ],
          )),
    );
  }
}
