import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlack,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            color: AppColors.offWhite,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
      ),
      backgroundColor: AppColors.lightBlack,
    );
  }
}
