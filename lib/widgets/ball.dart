import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double size;
  final Color? color;

  const Ball({super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(double.infinity)),
    );
  }
}
