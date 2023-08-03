import 'package:bloc/bloc.dart';
import 'package:food/cubits/product_cubit/products_state.dart';
import 'package:food/repository/api_service/api_service.dart';
import 'package:meta/meta.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  ApiServices fetchProduct = ApiServices();
  @override
  void fetchProducts() async {
    emit(ProductsLoading());
    try {
      final products = await fetchProduct.FetchProduct();
      emit(
        ProductsFetched(products),
      );
    } catch (e) {
      // Handle error state
    }
  }
}
