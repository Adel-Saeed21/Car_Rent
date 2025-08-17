import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String currentCity = "Loading...";
  bool isLoading = true;
  UserData? userData;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    loadUserData();
  }

  Future<void> loadUserData() async {
    var box = await Hive.openBox<UserData>('UserDataBox');
    setState(() {
      userData = box.get('currentUser');
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      PermissionStatus permission = await Permission.location.request();

      if (permission.isGranted) {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          setState(() {
            currentCity = "Location service disabled";
            isLoading = false;
          });
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.medium,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            currentCity =
                place.locality ?? place.administrativeArea ?? "Unknown City";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          currentCity = "Location permission denied";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        currentCity = "Error getting location";
        isLoading = false;
      });
      if (kDebugMode) {
        print("Location error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         "Hi, ${userData?.name ?? ""}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeightHelper.regular,
            fontSize: 17.sp,
          ),
        ),
        verticalSpace(5.h),
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.locationPinLock,
              color: Colors.white70,
              size: 16,
            ),
            horizontalSpace(2.w),
            isLoading
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                    ),
                  )
                : Text(
                    currentCity,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
          ],
        ),
      ],
    );
  }
}
