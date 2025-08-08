import 'package:carrent/core/helpers/app_regex.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/core/widgets/app_text_form_field.dart';
import 'package:carrent/feature/auth/log_in/logic/log_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool isSecured = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LogInCubit>().formKey,
      child: Column(
        children: [
          verticalSpace(20.h),
          AppTextFormField(
            controller: context.read<LogInCubit>().loginEmail,

            label: const Text("Email"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            radius: 16,
            textStyle: const TextStyle(color: Colors.white),
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
          ),
          verticalSpace(16.h),
          AppTextFormField(
            controller: context.read<LogInCubit>().loginPassword,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            label: const Text("Password"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            radius: 16,
            isSecure: isSecured,
            suffixIcon: IconButton(
              iconSize: 25,
              onPressed: () {
                setState(() {
                  isSecured = !isSecured;
                });
              },
              icon: isSecured
                  ? Icon(Icons.visibility_off, color: AppColors.lightBlue)
                  : Icon(Icons.visibility, color: AppColors.lightBlue),
            ),
            textStyle: const TextStyle(color: Colors.white),
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
          ),
          verticalSpace(16.h),
          AppButton(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            borderSide: BorderSide(color: AppColors.lightBlue),
            radius: 25,
            buttonWidth: 280.w,
            child: Text(
              "Login",
              style: TextStyle(color: AppColors.lightBlue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
