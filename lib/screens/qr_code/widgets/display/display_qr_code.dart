import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQrCode extends StatelessWidget {
  const DisplayQrCode({super.key});
  final code = 'sizni34dzihdeu3434yfdzcbdncoehjfuef5454342ajprzijrpeae';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 40,
                )),
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.zero,
                  height: MediaQuery.of(context).size.height * 0.63,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: QrImageView(
                      padding: EdgeInsets.zero,
                      data: code,
                      version: QrVersions.auto,
                      dataModuleStyle: QrDataModuleStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          dataModuleShape: QrDataModuleShape.square),
                      eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  )),
                ),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Transform.rotate(
                      angle: 90 * pi / 180,
                      child: Image.asset('assets/images/wave-logo-removebg.png',
                          width: 80),
                    ))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
