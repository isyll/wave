
import 'package:flutter/material.dart';
import 'package:waveapp/screens/gitfts/types/gift_item.dart';
import 'package:waveapp/utils/angle.dart';
import 'package:waveapp/widgets/ball.dart';

class GiftItemWidget extends StatelessWidget {
  final GiftItem item;

  const GiftItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
          color: const Color(0xffe1f5fe),
          border: Border.all(color: const Color(0xffd1dcde), width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/icons/gifts/Line-Chart.png',
                  width: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  '${item.remainingDays}j restants',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              item.text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  color: Color(0xff013763),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Transform.translate(
                offset: const Offset(0, -6),
                child: const Ball(size: 6, color: Color(0xff44b7e5)),
              ),
              const SizedBox(
                width: 16,
              ),
              Transform.rotate(
                angle: degAngle(5),
                child: Image.asset(
                  'assets/images/icons/gifts/Sparkling.png',
                  width: 24,
                ),
              ),
              const Expanded(child: SizedBox()),
              Transform.rotate(
                angle: degAngle(45),
                child: Image.asset(
                  'assets/images/icons/gifts/Trophy.png',
                  width: 32,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}