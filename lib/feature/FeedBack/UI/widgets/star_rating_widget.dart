import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final bool isInteractive;
  final Function(int)? onRatingChanged;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
    this.isInteractive = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData iconData;
        if (index < rating.floor()) {
          iconData = Icons.star;
        } else if (index < rating) {
          iconData = Icons.star_half;
        } else {
          iconData = Icons.star_border;
        }

        Widget star = Icon(
          iconData,
          color: color,
          size: size,
        );

        if (isInteractive) {
          return GestureDetector(
            onTap: () => onRatingChanged?.call(index + 1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: star,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: star,
        );
      }),
    );
  }
}