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
  
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeWidget();
  }

  Future<void> _initializeWidget() async {
    await Future.wait([
      _loadUserData(),
      _getCurrentLocation(),
    ]);
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
        print("Error loading user data: $e");
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Permission.location.request();
      
      if (!mounted || _isDisposed) return; 
      
      if (permission.isGranted) {
        final serviceEnabled = await Geolocator.isLocationServiceEnabled();
        
        if (!mounted || _isDisposed) return;
        
        if (!serviceEnabled) {
          _updateLocationState("Location service disabled");
          return;
        }

        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
          timeLimit: const Duration(seconds: 10), 
        );

        if (!mounted || _isDisposed) return;

        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (!mounted || _isDisposed) return;

        if (placemarks.isNotEmpty) {
          final place = placemarks[0];
          final cityName = place.locality ?? 
                          place.administrativeArea ?? 
                          place.subAdministrativeArea ?? 
                          "Unknown City";
          _updateLocationState(cityName);
        } else {
          _updateLocationState("Unknown location");
        }
      } else {
        _updateLocationState("Location permission denied");
      }
    } catch (e) {
      if (!mounted || _isDisposed) return;
      
      _updateLocationState("Error getting location");
      
      if (kDebugMode) {
        print("Location error: $e");
      }
    }
  }

  void _updateLocationState(String city) {
    if (mounted && !_isDisposed) {
      setState(() {
        currentCity = city;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreeting(),
        verticalSpace(5.h),
        _buildLocationRow(),
      ],
    );
  }

  Widget _buildGreeting() {
    return Text(
      "Hi, ${userData?.name ?? "Guest"}",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeightHelper.regular,
        fontSize: 17.sp,
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.locationPinLock,
          color: Colors.white70,
          size: 16.sp,
        ),
        horizontalSpace(6.w),
        _buildLocationContent(),
      ],
    );
  }

  Widget _buildLocationContent() {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12.w,
            height: 12.h,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
          ),
          horizontalSpace(8.w),
          Text(
            "Getting location...",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
            ),
          ),
        ],
      );
    }

    return Flexible(
      child: Text(
        currentCity,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14.sp,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// ignore: library_private_types_in_public_api
extension LocationWidgetExtension on _LocationWidgetState {
  Future<void> retryLocation() async {
    if (mounted && !_isDisposed) {
      setState(() {
        isLoading = true;
        currentCity = "Loading...";
      });
      await _getCurrentLocation();
    }
  }
}