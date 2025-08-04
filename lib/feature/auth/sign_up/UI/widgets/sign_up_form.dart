import 'package:carrent/core/di/di.dart';
import 'package:carrent/core/functions/show_toast.dart';
import 'package:carrent/core/helpers/app_regex.dart';
import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/core/widgets/app_text_form_field.dart';
import 'package:carrent/feature/auth/sign_up/UI/widgets/password_validation.dart';
import 'package:carrent/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:carrent/feature/auth/sign_up/logic/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignUpCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          verticalSpace(10.h),
          AppTextFormField(
            label: const Text("name"),
            labelStyle: AppTextStyle.font20LightBlueRgular,

            textStyle: const TextStyle(color: Colors.white),
            radius: 16,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().nameController,
          ),
          verticalSpace(10.h),
          AppTextFormField(
            radius: 14,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            label: const Text("Email"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            textStyle: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().emailController,
          ),
          verticalSpace(10.h),
          AppTextFormField(
            radius: 14,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            label: const Text("phone"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            textStyle: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().phoneController,
          ),
          verticalSpace(10.h),
          AppTextFormField(
            radius: 14,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            label: const Text("Password"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            textStyle: const TextStyle(color: Colors.white),

            controller: context.read<SignUpCubit>().passwordController,
            isSecure: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          verticalSpace(12.h),
          AppTextFormField(
            radius: 14,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            label: const Text("Password Confirm"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            textStyle: const TextStyle(color: Colors.white),

            controller: context
                .read<SignUpCubit>()
                .passwordConfirmationController,
            isSecure: isPasswordConfirmationObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordConfirmationObscureText =
                      !isPasswordConfirmationObscureText;
                });
              },
              child: Icon(
                isPasswordConfirmationObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          verticalSpace(12.h),

          PasswordValidation(
            hasLowerCase: hasLowercase,
            hasUpperCase: hasUppercase,
            hasSpecialChar: hasSpecialCharacters,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
          verticalSpace(12.h),

          BlocListener<SignUpCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                context.pushReplacmentNamed(Routes.logInScreen);
              } else {
                if (state is SignupError) {
                  showToast(state.errorMessage);
                }
              }
            },
            child: AppButton(
              buttonHeight: 40.h,
              textStyle: const TextStyle(color: Colors.white),
              onPressed: State is SignupLoading
                  ? null
                  : () {
                      if (getit<SignUpCubit>().formKey.currentState!
                          .validate()) {
                        getit<SignUpCubit>().signUp();
                      }
                    },

              child: State is SignupLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 24.0,
                      ),
                    )
                  : const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
