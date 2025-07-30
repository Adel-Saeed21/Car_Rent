import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}


