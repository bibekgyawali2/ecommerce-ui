import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/order.dart';
import '../../repository/api_service/api_service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  ApiServices apiServices = ApiServices(); // Create an instance of ApiServices

  void fetchOrders() async {
    emit(OrderLoading());
    try {
      final List<Order> orders =
          await apiServices.fetchOrder(); // Call the instance method
      emit(OrderFetched(orders: orders));
    } catch (e) {
      // Handle error state
      emit(OrderError());
    }
  }
}
