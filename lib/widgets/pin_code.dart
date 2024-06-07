import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinCode extends StatefulWidget {
  final void Function(int code) onCompleted;
  final void Function()? onForgotted;
  final int pinLength;

  const PinCode(
      {super.key,
      required this.onCompleted,
      required this.pinLength,
      this.onForgotted});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> with SingleTickerProviderStateMixin {
  String _pinCode = '';

  // Button for all digits.
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
          onPressed: () {
            setState(() {
              if (_pinCode.length < widget.pinLength) {
                _pinCode += number.toString();
              } else if (_pinCode.length == widget.pinLength) {
                widget.onCompleted(int.parse(_pinCode));
              }
            });
          },
          child: RepaintBoundary(
            child: Text(number.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 28)),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.pinLength, (index) {
              return Container(
                height: 18,
                width: 18,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index < _pinCode.length
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.activeBlue.withOpacity(0.15)),
                child: null,
              );
            }),
          ),
          const SizedBox(height: 75),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        numButton(1),
                        numButton(4),
                        numButton(7),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextButton(
                              child: Text(
                                l.forgot_password,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        numButton(2),
                        numButton(5),
                        numButton(8),
                        numButton(0),
                      ],
                    ),
                    Column(children: [
                      numButton(3),
                      numButton(6),
                      numButton(9),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: IconButton(
                            onPressed: _pinCode.isNotEmpty
                                ? () {
                                    setState(() {
                                      _pinCode = _pinCode.substring(
                                          0, _pinCode.length - 1);
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.backspace)),
                      )
                    ])
                  ])),
        ],
      ),
    );
  }
}
