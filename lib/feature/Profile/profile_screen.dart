import 'dart:io';
import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/routing/routes.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData? userData;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final box = await Hive.openBox<UserData>('UserDataBox');
      if (mounted && !_isDisposed) {
        setState(() {
          userData = box.get('currentUser');
        });
      }
    } catch (e) {
      if (kDebugMode) {
        
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(20.h),
            _ProfileDetails(userData: userData),
            verticalSpace(20.h),
            _MenuSection(
              title: "Setting",
              items: [
                _MenuItem(
                  icon: Icons.person_4_rounded,
                  title: "Personal Information",
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.payment,
                  title: "Payment methods",
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.favorite,
                  title: "My Favorites",
                  onTap: () => Navigator.pushNamed(context, Routes.favorite),
                ),
                _MenuItem(
                  icon: Icons.reviews,
                  title: "My Feedbacks",
                  onTap: () => Navigator.pushNamed(context, Routes.feedback),
                ),
                _MenuItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  onTap: () {},
                ),
              ],
            ),
            verticalSpace(20.h),
            _MenuSection(
              title: "Hosting",
              items: [
                _MenuItem(
                  icon: Icons.car_rental,
                  title: "Become a host",
                  onTap: () {},
                ),
              ],
            ),
            verticalSpace(20.h),
            _MenuSection(
              title: "Support",
              items: [
                _MenuItem(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.contact_support,
                  title: "Contact Us",
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.info_outline,
                  title: "About",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 
class _ProfileDetails extends StatelessWidget {
  final UserData? userData;

  const _ProfileDetails({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Row(
          children: [
            _ProfileImage(userData: userData),
            horizontalSpace(12.w),
           const _ProfileInfo(),
          ],
        ),
      ),
    );
  }
}

 
class _ProfileImage extends StatelessWidget {
  final UserData? userData;

  const _ProfileImage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 90.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child:
            userData?.profileImagePath != null &&
                userData!.profileImagePath!.isNotEmpty
            ? Image.file(File(userData!.profileImagePath!), fit: BoxFit.cover)
            : Image.asset("assets/images/adool.jpeg", fit: BoxFit.cover),
      ),
    );
  }
}

 
class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text("Adool", style: AppTextStyle.font20WhiteRgular),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Show Profile",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 20.w),
      width: 330.w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.font20WhiteRgular),
          verticalSpace(10.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _SettingItem(
                icon: item.icon,
                title: item.title,
                onTap: item.onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

 
class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.r),
                  color: AppColors.darkGrey,
                ),
                child: Icon(icon, color: Colors.white),
              ),
              horizontalSpace(15.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.offWhite,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
