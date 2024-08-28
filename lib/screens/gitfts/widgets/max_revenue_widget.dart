import 'package:flutter/material.dart';
import 'package:waveapp/utils/format.dart';

class MaxRevenueWidget extends StatelessWidget {
  final int revenue;

  const MaxRevenueWidget({
    super.key,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    final formattedRevenue = formatNumber(revenue.toDouble(), replace: '.');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      decoration: BoxDecoration(
          color: const Color(0Xffc7fabf),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icons/home/Gift.png',
            width: 50,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text("Gagnez jusqu'à "),
          Text(
            '${formattedRevenue}F',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
