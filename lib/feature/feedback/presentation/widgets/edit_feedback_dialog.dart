import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/core/widgets/app_button.dart';
import 'package:carrent/core/widgets/app_text_form_field.dart';
import 'package:carrent/feature/feedback/presentation/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 
class EditFeedbackDialog extends StatefulWidget {
  final String carName;
  final double initialRating;
  final String initialComment;
  final bool isEditing;
  final Function(double rating, String comment) onSave;

  const EditFeedbackDialog({
    super.key,
    required this.carName,
    this.initialRating = 0.0,
    this.initialComment = '',
    this.isEditing = false,
    required this.onSave,
  });

  @override
  State<EditFeedbackDialog> createState() => _EditFeedbackDialogState();
}

class _EditFeedbackDialogState extends State<EditFeedbackDialog> {
  late double _rating;
  late TextEditingController _commentController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _commentController = TextEditingController(text: widget.initialComment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isEditing ? 'Edit Feedback' : 'Rate Your Experience',
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(10.h),
              Text(
                'How was your experience with ${widget.carName}?',
                style: AppTextStyle.font20WhiteRgular.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.offWhite,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(20.h),
              Center(
                child: StarRatingWidget(
                  rating: _rating,
                  size: 40.sp,
                  isInteractive: true,
                  onRatingChanged: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              verticalSpace(20.h),
              AppTextFormField(
                controller: _commentController,
                hintText: 'Write your comment...',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                radius: 20,
                focusBorderColor: AppColors.lightBlue,
                enableBorderColor: AppColors.offWhite,
              ),
              verticalSpace(20.h),
              AppButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_rating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a rating'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    widget.onSave(_rating, _commentController.text);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
