import 'package:food/modals/product_modals.dart';
import 'package:dio/dio.dart';

String BASE_URL = 'https://349d-103-134-216-118.ngrok-free.app';

String PopularProduct = BASE_URL + '/api/viewproducts_details';

class ApiServices {
  Dio _dio = Dio();

  Future<List<ProductsModel>> FetchProduct() async {
    try {
      final options = Options(headers: {
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      var response = await _dio.get(PopularProduct, options: options);
      var list = List<ProductsModel>.from(
          response.data.map((x) => ProductsModel.fromMap(x)));
      return list;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
