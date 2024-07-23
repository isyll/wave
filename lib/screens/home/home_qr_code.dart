import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeQrCode extends StatefulWidget {
  const HomeQrCode({super.key});

  @override
  State<HomeQrCode> createState() => _HomeQrCodeState();
}

class _HomeQrCodeState extends State<HomeQrCode> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 320,
          height: 184,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.secondary),
          child: const Center(
            child: _QrCode(code: '123456789012345678901234567890'),
          ),
        ),
        Positioned(
            bottom: 14,
            right: 1,
            child:
                Image.asset('assets/images/wave-logo-removebg.png', width: 64))
      ],
    );
  }
}

class _QrCode extends StatelessWidget {
  final dynamic code;

  const _QrCode({
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(
          top: 12.0, left: 12.0, right: 12.0, bottom: 2.0),
      width: 150,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          QrImageView(
            padding: EdgeInsets.zero,
            size: 110,
            data: code,
            version: QrVersions.auto,
            dataModuleStyle: QrDataModuleStyle(
                color: Theme.of(context).colorScheme.onSurface,
                dataModuleShape: QrDataModuleShape.square),
            eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Theme.of(context).colorScheme.onSurface),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  l.scan_qr_code,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
