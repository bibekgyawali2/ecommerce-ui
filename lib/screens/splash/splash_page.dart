import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food/screens/home/home_page.dart';
import 'package:get/get.dart';

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
    Timer(
        const Duration(seconds: 3),
        () => {
              Get.off(
                HomePage(),
              )
            });
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
              ))),
          Center(
              child: Image.asset(
            "assets/image/flogo.png",
            width: Dimensions.splashImg,
          )),
        ],
      ),
    );
  }
}
