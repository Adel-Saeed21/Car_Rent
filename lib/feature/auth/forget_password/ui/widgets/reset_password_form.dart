import 'package:carrent/core/functions/show_toast.dart';
import 'package:carrent/core/helpers/app_regex.dart';
import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/core/widgets/app_text_form_field.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_cubit.dart';
import 'package:carrent/feature/auth/forget_password/logic/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late TextEditingController emailResetPasswordController;

  @override
  void initState() {
    super.initState();
    emailResetPasswordController = context
        .read<ResetPasswordCubit>()
        .emailResetPasswordController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ResetPasswordCubit>().formKey,
      child: Column(
        children: [
          verticalSpace(10.h),
          AppTextFormField(
            radius: 16.r,
            focusBorderColor: AppColors.lightBlue,
            enableBorderColor: Colors.grey,
            label: const Text("Email"),
            labelStyle: AppTextStyle.font20LightBlueRgular,
            controller: emailResetPasswordController,
            textStyle: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          verticalSpace(10.h),
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                showToast('If this email exists, we\'ve sent a password reset link');
                 
                Future.delayed(const Duration(seconds: 3), () {
                  // ignore: use_build_context_synchronously
                  context.pushReplacmentNamed(Routes.logInScreen);
                });
              } else if (state is ResetPasswordError) {
                showToast(state.errorMessage);
              }
            },
            builder: (context, state) {
              return AppButton(
                buttonHeight: 40.h,
                textStyle: const TextStyle(color: Colors.white),
                onPressed: state is ResetPasswordEmailLoading
                    ? null
                    : () {
                        if (context
                                .read<ResetPasswordCubit>()
                                .formKey
                                .currentState
                                ?.validate() ??
                            false) {
                           
                          context
                              .read<ResetPasswordCubit>()
                              .sendPasswordResetEmail();
                        }
                      },
                child: state is ResetPasswordEmailLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 24.0,
                        ),
                      )
                    : const Text(
                        "Send Reset Link",
                        style: TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}