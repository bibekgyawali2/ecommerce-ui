import 'package:flutter/material.dart';
import 'package:food/modals/product_modals.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:food/screens/cart/cart_page.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_column.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/expandable_text_widget.dart';

class PopularFoodDetail extends StatefulWidget {
  final ProductsModel products;
  //final String page;

  const PopularFoodDetail({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController =
        TextEditingController(text: 1.toString());
    int totalItems = 1; // Initialize the quantity to 1

    @override
    void initState() {
      super.initState();
      quantityController.text = totalItems.toString();
    }

    void increaseQuantity() {
      if (totalItems < 10) {
        totalItems++;
        quantityController.text = totalItems.toString();
      }
    }

    void decreaseQuantity() {
      if (totalItems > 1) {
        totalItems--;
        quantityController.text = totalItems.toString();
      }
    }

    // void addItem(Product product) {
    //   // Add item to cart
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.poularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(IMAGE_URL + widget.products.img!),
                ),
              ),
            ),
          ),
          // Icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GestureDetector(
                  onTap: () {
                    if (totalItems >= 1) {
                      //Navigator.pushNamed(context, RouteHelper.getCartPage());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.poularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: widget.products.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text: widget.products.description!),
                    ),
                  ),
                ],
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
            right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      decreaseQuantity();

                      print(totalItems);
                    },
                    child: Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.width10 / 2),
                  Container(
                    width: 40, // Adjust the width as needed
                    alignment: Alignment.center,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: Dimensions.width10 / 2),
                  GestureDetector(
                    onTap: () {
                      increaseQuantity();
                      print(totalItems);
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                //   addItem(product);
                bool success =
                    await ApiServices().addToCart(widget.products, totalItems);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: "\RS ${widget.products.price} | Add to cart",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PopularProduct {
  final int id;
  final String name;
  final String img;
  final String description;
  final double price;

  PopularProduct({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
    required this.price,
  });
}
