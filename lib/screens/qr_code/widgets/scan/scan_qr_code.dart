import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/qr_code/widgets/scan/qr_button_widgets.dart';
import 'package:waveapp/screens/qr_code/widgets/scan/qr_overlay.dart';
import 'package:waveapp/screens/transactions/transfer/transfer_screen.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> with WidgetsBindingObserver {
  StreamSubscription<Object?>? subscription;
  Barcode? barcode;
  final controller = MobileScannerController(
      autoStart: true,
      torchEnabled: false,
      useNewCameraSelector: true,
      detectionSpeed: DetectionSpeed.noDuplicates);
  final audioPlayer = AudioPlayer();

  void handleBarcodes(BarcodeCapture barcodes) async {
    if (mounted) {
      final navigator = Navigator.of(context);
      barcode = barcodes.barcodes.firstOrNull;

      await audioPlayer.play(AssetSource('sounds/beep.mp3'));
      navigator.pushReplacementNamed(TransferScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    subscription = controller.barcodes.listen(handleBarcodes);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        subscription = controller.barcodes.listen(handleBarcodes);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(subscription?.cancel());
        subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context).width * 0.85;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: size,
      height: size,
    );
    final top = MediaQuery.sizeOf(context).center(Offset.zero).dy * 0.42;

    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: controller,
          scanWindow: scanWindow,
        ),
        ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            if (!value.isInitialized ||
                !value.isRunning ||
                value.error != null) {
              return const SizedBox();
            }
            return CustomPaint(
              painter: QrOverlay(scanWindow: scanWindow),
            );
          },
        ),
        Positioned(
          bottom: top,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              l.scan_for_pay,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 32.0,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ToggleFlashlightButton(
                  controller: controller,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(subscription?.cancel());
    subscription = null;
    super.dispose();
    await controller.dispose();
  }
}
