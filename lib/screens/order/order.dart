import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cubit/order_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).fetchOrders();
    // Trigger the initial refresh when the widget is first built
    Future.microtask(() {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  // Add a method to handle the refresh action
  Future<void> _onRefresh() async {
    BlocProvider.of<OrderCubit>(context).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Orders'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh, // Specify the refresh callback
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderFetched) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColor),
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
                            ),
                          ),
                        ),
                      ),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: 'Order ID:'),
                          BigText(text: order.id.toString()),
                        ],
                      ),
                      subtitle: SmallText(text: order.price),
                      trailing: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          border: Border.all(color: AppColors.mainColor),
                        ),
                        child: SmallText(
                            text:
                                order.status == '0' ? 'approved' : 'delivered',
                            color: AppColors.mainColor),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
