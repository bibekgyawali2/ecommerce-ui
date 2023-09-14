import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cubit/order_cubit.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Orders'),
        elevation: 0,
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderFetched) {
            return Column(
              children: [
                // Container(
                //   height: 80,
                //   color: AppColors.mainColor,
                //   width: double.maxFinite,
                //   padding: EdgeInsets.only(top: Dimensions.height45),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       BigText(text: "Orders", color: Colors.white),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          Container(
                            height: Dimensions.height30 * 4,
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(direction: Axis.horizontal, children: [
                                      Container(
                                        height: Dimensions.height20 * 4,
                                        width: Dimensions.height20 * 4,
                                        margin: EdgeInsets.only(
                                            right: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 2),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
                                          ),
                                        ),
                                      )
                                    ]),
                                    GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(RouteHelper.getCartPage());
                                      },
                                      child: Container(
                                        height: Dimensions.height20 * 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(
                                                text: "Rs 100",
                                                color: AppColors.titleColor),
                                            BigText(
                                                text: "Items",
                                                color: AppColors.titleColor),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
                                                  vertical:
                                                      Dimensions.height10 / 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.mainColor),
                                              ),
                                              child: SmallText(
                                                  text: "Pending",
                                                  color: AppColors.mainColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
