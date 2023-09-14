part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderFetched extends OrderState {
  final List<Order> orders;

  OrderFetched({required this.orders});
}

final class OrderLoading extends OrderState {}

final class OrderError extends OrderState {}
