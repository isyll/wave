import 'package:flutter/material.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key, required this.onScanned});

  final Function(dynamic data) onScanned;

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
