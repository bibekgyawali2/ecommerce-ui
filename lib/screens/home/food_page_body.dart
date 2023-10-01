import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food/cubits/cubit/popular_cubit.dart';
import 'package:food/cubits/product_cubit/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/modals/product_modals.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:food/screens/food/popular_food_detail.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubits/product_cubit/products_state.dart';
import '../../modals/order.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text.dart';
import '../../widget/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    getData();
  }

  String? Name;
  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      Name = await prefs.getString('name');
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PopularCubit, PopularState>(
          builder: (context, state) {
            if (state is PopularFetched) {
              return Container(
                height: Dimensions.pageView,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: state.products
                      .length, // Set the item count according to your needs
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, state.products[position]);
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        DotsIndicator(
          dotsCount: 6, // Set the dots count according to your needs
          position: _currPageValue.toInt(),
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsFetched) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.products
                    .length, // Set the item count according to your needs
                itemBuilder: (context, index) {
                  print(state.products[index].img);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PopularFoodDetail(
                            products: state.products[index],
                            name: Name!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.ListViewImgSize,
                            height: Dimensions.ListViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  IMAGE_URL + state.products[index].img!,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.ListViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: state.products[index].name!),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(
                                      text: state.products[index].description!,
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1,
                                        ),
                                        // IconAndTextWidget(
                                        //   icon: Icons.location_on,
                                        //   text: "1.7km",
                                        //   iconColor: AppColors.mainColor,
                                        // ),
                                        IconAndTextWidget(
                                          icon: Icons.monetization_on,
                                          text: state.products[index].price,
                                          iconColor: AppColors.iconColor2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductsModel product) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PopularFoodDetail(
                    products: product,
                    name: Name!,
                  ),
                ),
              );
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    IMAGE_URL + product.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: 15,
                  right: 15,
                ),
                child: AppColumn(
                  text: product.name!,
                  price: product.price,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
