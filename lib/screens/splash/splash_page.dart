import 'package:flutter/material.dart';
import 'package:food/screens/auth/sign_in_page.dart';
import 'package:food/screens/home/home_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    // Check if SharedPreferences has data
    checkSharedPreferencesData();
  }

  double? latitude;
  double? longitude;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;

      // Use the latitude and longitude as needed
      print('Latitude: $latitude, Longitude: $longitude');
    } catch (e) {
      // Handle any errors that may occur while getting the location
      print('Error: $e');
    }
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where the user denied the permission
        // You may want to show an error message or provide instructions on how to enable location services.
      }
    }
  }

  Future<void> checkSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if your data exists in SharedPreferences, replace 'yourKey' with the actual key you use
    if (prefs.containsKey('token')) {
      // Data exists, navigate to the home page
      navigateToHomePage();
    } else {
      // Data doesn't exist, navigate to the login page
      navigateToLoginPage();
    }
  }

  void navigateToHomePage() {
    Get.off(HomePage());
  }

  void navigateToLoginPage() {
    Get.off(SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/foodlogo1.jpg",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/image/flogo.png",
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
