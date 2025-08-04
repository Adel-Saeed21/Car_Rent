import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize =>const  Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightBlack,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.lightBlue),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Sign Up',
        style: TextStyle(
          color: AppColors.lightBlue,
          fontSize: 20.sp,
          fontWeight: FontWeightHelper.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
