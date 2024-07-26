import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:waveapp/screens/qr_code/widgets/display_qr_code.dart';
import 'package:waveapp/screens/qr_code/widgets/scan/scan_qr_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});
  static const String routeName = '/qr-code';

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool showScanner = true;
  final AudioPlayer audioPlayer = AudioPlayer();

  void toggle() {
    setState(() {
      showScanner = !showScanner;
    });
  }

  Widget get _widget =>
      showScanner ? ScanQrCode() : const DisplayQrCode();

  Widget _textButton(String text, bool current) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                current ? Colors.white54 : Colors.transparent),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)))),
        onPressed: toggle,
        child: Text(
          softWrap: false,
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.surface),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
        body: Stack(
      children: [
        _widget,
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black.withOpacity(0.75)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140,
                    child: _textButton(l.scan_code, showScanner),
                  ),
                  SizedBox(
                    width: 140,
                    child: _textButton(l.my_card, !showScanner),
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
