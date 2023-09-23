import 'package:flutter/material.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:geolocator/geolocator.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import 'food_page_body.dart';

class MainFoodPaage extends StatefulWidget {
  const MainFoodPaage({Key? key}) : super(key: key);

  @override
  State<MainFoodPaage> createState() => _MainFoodPaageState();
}

class _MainFoodPaageState extends State<MainFoodPaage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationPermission();
    getCurrentLocation();
  }

  Map<String, String>? location;
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

      location = await ApiServices().fetchLocation(latitude!, longitude!);
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                        text: location != null
                            ? '${location!['city']}'
                            : 'Loading...',
                        color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(
                          text: location != null
                              ? '${location!['municipality']}'
                              : 'Loading...',
                          color: Colors.black54,
                        ),
                        // const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                // Center(
                //   child: Container(
                //     width: Dimensions.height45,
                //     height: Dimensions.height45,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(Dimensions.radius15),
                //       color: AppColors.mainColor,
                //     ),
                //     child: Icon(
                //       Icons.search,
                //       color: Colors.white,
                //       size: Dimensions.iconSize24,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
        const Expanded(
            child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    );
  }
}
