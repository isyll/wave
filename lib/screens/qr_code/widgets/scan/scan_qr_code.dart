import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waveapp/screens/qr_code/widgets/scan/qr_button_widgets.dart';
import 'package:waveapp/screens/qr_code/widgets/scan/qr_overlay.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key, required this.onDetect});

  final Function(BarcodeCapture data) onDetect;

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> with WidgetsBindingObserver {
  StreamSubscription<Object?>? _subscription;
  final controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );

  AppLocalizations get l => AppLocalizations.of(context)!;
  Widget get _overlay {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
      child: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.flash_on)),
            ],
          )),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16)),
            height: 200,
            width: 200,
          ),
          TextButton(onPressed: () {}, child: Text(l.scan_for_pay))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(widget.onDetect);

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
        _subscription = controller.barcodes.listen(widget.onDetect);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onDetect: widget.onDetect,
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
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}
