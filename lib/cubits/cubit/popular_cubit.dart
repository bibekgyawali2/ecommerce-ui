import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/product_modals.dart';
import '../../repository/api_service/api_service.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());
  ApiServices fetchProduct = ApiServices();
  @override
  void fetchProducts() async {
    emit(PopularLoading());
    try {
      final products = await fetchProduct.FetchProduct();
      emit(
        PopularFetched(products),
      );
    } catch (e) {
      // Handle error state
    }
  }
}
