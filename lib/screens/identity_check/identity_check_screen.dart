import 'package:flutter/material.dart';

class IdentityCheckScreen extends StatefulWidget {
  static const routeName = '/identity-check';

  const IdentityCheckScreen({super.key});

  @override
  State<IdentityCheckScreen> createState() => _IdentityCheckScreenState();
}

class _IdentityCheckScreenState extends State<IdentityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const Placeholder());
  }
}
