import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:food/screens/khalti/khalti.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  String? name;
  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      name = await prefs.getString('name');
    });
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<CartCubit>(context).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Cart'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartFetched) {
              return SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: Dimensions.height20 * 1,
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
                                              IMAGE_URL +
                                                  state.cart[index].img!,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            await ApiServices()
                                                                .delete_cart(state
                                                                    .cart[index]
                                                                    .id!);
                                                            BlocProvider.of<
                                                                        CartCubit>(
                                                                    context)
                                                                .fetchCart();
                                                          },
                                                          icon: Icon(
                                                              Icons.delete))
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
                ),
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
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KhaltiExampleApp(),
            ),
          );
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: AppColors.mainColor,
            ),
            child: BigText(
              text: "Check out",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
