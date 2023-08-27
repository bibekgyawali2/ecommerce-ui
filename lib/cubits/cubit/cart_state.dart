part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFetched extends CartState {
  final List<Cart> cart;

  CartFetched(this.cart);
}
