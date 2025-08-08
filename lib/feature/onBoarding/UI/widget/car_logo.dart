import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarvOnLogo extends StatelessWidget {
  const CarvOnLogo({
    super.key,
    this.color,
    this.carheighSize,
    this.nameSize,
    this.appear,
    this.carWidthSize,
  });

  final Color? color;
  final double? carheighSize;
  final double? carWidthSize;
  final double? nameSize;
  final bool? appear;

  @override
  Widget build(BuildContext context) {
    bool display = appear ?? true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.assetsImagesCar,
              width: carWidthSize ?? 37.w,
              height: carheighSize ?? 37.h,
              color: color ?? Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              'CarvOn',
              style: TextStyle(
                fontSize: 35.sp,
                color: Colors.white,
                fontWeight: FontWeightHelper.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ?display
            ? const Text(
                'Redefine Your Ride with CarvaOn',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              )
            : null,
      ],
    );
  }
}
