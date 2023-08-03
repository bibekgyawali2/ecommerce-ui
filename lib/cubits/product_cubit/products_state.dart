import '../../modals/product_modals.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsFetched extends ProductsState {
  final List<ProductsModel> products;

  ProductsFetched(this.products);
}

class ProductsFetchError extends ProductsState {}
