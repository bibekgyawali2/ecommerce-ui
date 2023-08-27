import 'package:bloc/bloc.dart';
import 'package:food/modals/cart.dart';
import 'package:meta/meta.dart';

import '../../repository/api_service/api_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  ApiServices fetchCarts = ApiServices();
  void fetchCart() async {
    emit(CartLoading());
    try {
      final cart = await fetchCarts.fetchCart();
      emit(
        CartFetched(cart),
      );
    } catch (e) {
      // Handle error state
    }
  }
}
