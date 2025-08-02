import 'package:carrent/core/helpers/extensions.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: AppTextStyle.font20LightBlueRgular.copyWith(fontSize: 14),
          ),
          TextSpan(
            text: ' Login',
            style: AppTextStyle.font20LightBlueRgular.copyWith(
              fontSize: 14,
              fontWeight: FontWeightHelper.semiBold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacmentNamed(Routes.logInScreen);
              },
          ),
        ],
      ),
    );
  }
}
