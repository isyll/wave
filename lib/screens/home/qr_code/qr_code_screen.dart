import 'package:flutter/material.dart';
import 'package:waveapp/screens/home/qr_code/widgets/display_qr_code.dart';
import 'package:waveapp/screens/home/qr_code/widgets/scan_qr_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});
  static const String routeName = '/qr-code';

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool _showScanner = true;

  void _toggle() {
    setState(() {
      _showScanner = !_showScanner;
    });
  }

  void _showScannerCode(dynamic data) {
    print(data);
  }

  Widget get _widget => _showScanner
      ? ScanQrCode(onScanned: _showScannerCode)
      : const DisplayQrCode();

  Widget _textButton(String text, bool current) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                current ? Colors.white54 : Colors.transparent),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)))),
        onPressed: _toggle,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
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
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black.withOpacity(0.75)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: _textButton(l.scan_code, _showScanner),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    width: 170,
                    child: _textButton(l.my_card, !_showScanner),
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
