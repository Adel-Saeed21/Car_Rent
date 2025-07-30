import 'package:carrent/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CarvOnLogo extends StatelessWidget {
  const CarvOnLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.assetsImagesCar,
              width: 37,
              height: 37,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            const Text(
              'CarvOn',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Redefine Your Ride with CarvaOn',
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
