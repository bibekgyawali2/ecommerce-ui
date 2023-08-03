import 'package:flutter/material.dart';

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
                  children: [
                    BigText(text: "Nepal", color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(
                          text: "Damak",
                          color: Colors.black54,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                )
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
