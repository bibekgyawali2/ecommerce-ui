import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:food/screens/khalti/khalti.dart';
import '../../cubits/cubit/cart_cubit.dart';
import '../../modals/cart.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  double calculateTotalPrice(List<Cart> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      if (item.price != null) {
        total += double.tryParse(item.price!) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartFetched) {
            return Stack(
              children: [
                Positioned(
                  top: Dimensions.height20 * 1,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back_ios,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      // SizedBox(
                      //   width: Dimensions.width20 * 5,
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: AppIcon(
                      //     icon: Icons.home_outlined,
                      //     iconColor: Colors.white,
                      //     backgroundColor: AppColors.mainColor,
                      //     iconSize: Dimensions.iconSize24,
                      //   ),
                      // ),
                      // AppIcon(
                      //   icon: Icons.shopping_cart,
                      //   iconColor: Colors.white,
                      //   backgroundColor: AppColors.mainColor,
                      //   iconSize: Dimensions.iconSize24,
                      // )
                    ],
                  ),
                ),
                Positioned(
                  top: Dimensions.height20 * 3,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: state.cart
                            .length, // Replace with the desired number of items
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
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: state.cart[index]
                                              .product!, // Replace with dynamic text
                                          color: Colors.black54,
                                        ),
                                        // SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: state.cart[index]
                                                  .price!, // Replace with dynamic price
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
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  BigText(
                                                    text:
                                                        "0", // Replace with dynamic quantity
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(
                            text:
                                "\RS ${calculateTotalPrice(state.cart).toStringAsFixed(2)}", // Replace with dynamic total amount
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
            );
          } else if (state is CartLoading) {
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else {
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('RETRY'),
                ),
                Center(
                  child: Text('Something Went Wrong'),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          // Navigator.push(
          // context,
          // MaterialPageRoute(
          //   builder: (context) => KhaltiExampleApp(),
          // ),
          // );
          List<Cart> cartItems =
              (BlocProvider.of<CartCubit>(context).state as CartFetched).cart;
          List<int> ids = [];
          String name = "";
          double price = 0.0;
          String img = "";
          int totalQuantity = 0;
          String product = "";
          String time = "";
          for (var item in cartItems) {
            var a = item.id;
            ids.add(a!);
            name += item.product ?? ""; // Concatenate product name
            double itemPrice = double.tryParse(item.price ?? "0") ?? 0;
            int itemQuantity = item.quantity ?? 0; // No need for conversion
            totalQuantity += itemQuantity;
            price += itemPrice; // Concatenate price
            // Concatenate other fields in a similar manner

            // You might want to add some separator if needed
            name += ", ";

            // Add separators for other fields

            // Assuming you only want to add one image URL
            img = item.img ?? img;
          }

          // Remove trailing separators
          name = name.isNotEmpty ? name.substring(0, name.length - 2) : "";
          // Remove trailing separators for other fields

          // Now you can call the API with the concatenated values
          setState(() {
            isLoading = true;
          });

          bool orderStatus = await ApiServices().addOrder(
            name: 'user name',
            price: price,
            quantity: totalQuantity,
            product: ids,
            time: DateTime.now(),
          );
          if (orderStatus) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Successfully Ordered"),
                duration: const Duration(seconds: 1)));
          }
          setState(() {
            isLoading = false;
          });
          print(orderStatus);
        },
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
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : BigText(
                    text: "Check out",
                    color: Colors.white,
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: AppColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
