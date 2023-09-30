import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

    bool isloading = false;
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
                  AppColumn(
                    text: widget.products.name!,
                    price: widget.products.price,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text: widget.products.description!),
                    ),
                  ),
                  RatingBar.builder(
                    itemSize: 20,
                    initialRating: widget.products.stars
                        .toDouble(), // Initial rating value, set to 0 initially
                    minRating: 1, // Minimum rating
                    direction: Axis.horizontal,
                    allowHalfRating:
                        true, // Set to true if you want to allow half-star ratings
                    itemCount: 5, // The number of stars
                    itemPadding: const EdgeInsets.symmetric(
                        horizontal: 4.0), // Padding between stars
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber, // Star color when filled
                    ),
                    onRatingUpdate: (rating) {
                      ApiServices().rating(
                        rating: rating,
                        productid: widget.products.id,
                        message: "true",
                      );
                    },
                  )
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
                    child: const Icon(
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: Dimensions.width10 / 2),
                  GestureDetector(
                    onTap: () {
                      increaseQuantity();
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!isloading) {
                  setState(() {
                    isloading = true;
                  });
                  try {
                    bool success = await ApiServices()
                        .addToCart(widget.products, totalItems);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Added to Cart"),
                          duration: Duration(seconds: 1)));
                    }
                  } catch (e) {
                  } finally {
                    setState(() {
                      isloading = false;
                    });
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
                child: isloading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : BigText(
                        text: "\RS ${widget.products.price} | Add to cart",
                        color: Colors.white,
                        size: 15,
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
