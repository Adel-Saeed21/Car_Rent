import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetailsAppBar extends StatelessWidget {
  const CarDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlack,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: AppColors.offWhite,
                    ),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.offWhite,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Text(
                "Car Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.offWhite,
                  fontSize: 22,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
