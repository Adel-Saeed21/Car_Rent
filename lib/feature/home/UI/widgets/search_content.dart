import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/home/UI/widgets/car_info_widget.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContent extends StatelessWidget {
  final bool isSearchLoading;
  final List<CarModel> searchResults;
  final String searchQuery;
  final double screenWidth;
  final VoidCallback onClearSearch;
  final Function(String) onSuggestionTap;

  const SearchContent({
    super.key,
    required this.isSearchLoading,
    required this.searchResults,
    required this.searchQuery,
    required this.screenWidth,
    required this.onClearSearch,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearchLoading) {
      return _buildSearchLoadingState();
    }

    if (searchResults.isEmpty) {
      return _buildSearchEmptyState();
    }

    return _buildSearchResults();
  }

  Widget _buildSearchLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.lightBlue,
                strokeWidth: 3,
              ),
            ),
          ),
          verticalSpace(20.h),
          Text(
            "searching for Cars",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 16.sp,
              color: AppColors.lightBlue,
            ),
          ),
          verticalSpace(8.h),
          Text(
            "\"$searchQuery\"",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 14.sp,
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off,
                size: 50.sp,
                color: Colors.grey[600],
              ),
            ),
            verticalSpace(20.h),
            Text(
              "No Result",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 18.sp,
                color: Colors.grey[400],
              ),
            ),
            verticalSpace(8.h),
            Text(
              "don't have car with this name\"$searchQuery\"",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20.h),
            Text(
              "Try to search about:",
              style: AppTextStyle.font20WhiteRgular.copyWith(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
            verticalSpace(10.h),
            Wrap(
              spacing: 8.w,
              children: ['BMW', 'Mercedes', 'Toyota', 'Honda']
                  .map(
                    (suggestion) => GestureDetector(
                      onTap: () => onSuggestionTap(suggestion),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: AppColors.lightBlue.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          suggestion,
                          style: TextStyle(
                            color: AppColors.lightBlue,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "found ${searchResults.length} car",
            style: AppTextStyle.font20WhiteRgular.copyWith(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
        ),
        verticalSpace(10.h),

        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return CarInfoWidget(
                car: searchResults[index],
                screenWidth: screenWidth,
              );
            },
            separatorBuilder: (context, index) => verticalSpace(16.h),
          ),
        ),
      ],
    );
  }
}
