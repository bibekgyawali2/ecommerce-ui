import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    //Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                )
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: 2, // Replace with the desired number of items
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle product tap
                            },
                            child: Container(
                              width: Dimensions.height20 * 5,
                              height: Dimensions.height20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
                                  ),
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.height20 * 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(
                                    text:
                                        "Product Name", // Replace with dynamic text
                                    color: Colors.black54,
                                  ),
                                  SmallText(text: "Spicy"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text:
                                            "Price", // Replace with dynamic price
                                        color: Colors.redAccent,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: Dimensions.height10,
                                          bottom: Dimensions.height10,
                                          left: Dimensions.width10,
                                          right: Dimensions.width10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.remove,
                                              color: AppColors.signColor,
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            BigText(
                                              text:
                                                  "0", // Replace with dynamic quantity
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            Icon(
                                              Icons.add,
                                              color: AppColors.signColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(
                      text: "\RS 0", // Replace with dynamic total amount
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height30,
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: Dimensions.height20,
            bottom: Dimensions.height20,
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          child: BigText(
            text: "Check out",
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}
