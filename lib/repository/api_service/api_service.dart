import 'dart:convert';
import 'package:food/modals/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/modals/product_modals.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String BASE_URL =
    'https://21f9-2400-1a00-bd20-d7f9-3197-de63-1c3b-de9a.ngrok-free.app';

String PopularProduct = BASE_URL + '/api/viewproducts_details';
String AddToCart = BASE_URL + '/api/addcart_details';
String MAKE_ORDER = BASE_URL + '/api/addorder_details';
String sign_in = BASE_URL + '/api/login';
String get_cart = BASE_URL + '/api/cart_details';

class ApiServices {
  Dio _dio = Dio();

  Future<List<ProductsModel>> FetchProduct() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // if (token == null) {
      //   throw Exception("Token not found");
      // }

      final options = Options(headers: {
        "ngrok-skip-browser-warning": "69420",
        "accept": "application/json",
        "Authorization": "Bearer $token", // Add bearer token
      });

      final response = await _dio.get(PopularProduct, options: options);
      final list = List<ProductsModel>.from(
          response.data.map((x) => ProductsModel.fromMap(x)));
      return list;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> signUp(
      String fName, String email, String password, String phone) async {
    try {
      final options = Options(headers: {
        'accept': 'application/json',
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      final Map<String, dynamic> requestBody = {
        'name': fName,
        'email': email,
        'password': password,
        'confirm_password': password,
      };
      var response = await _dio.post(BASE_URL + '/api/register',
          data: requestBody, options: options);
      print(response);
      if (response.statusCode == 200) {
        var a = response.data;
        // Successful sign-up
        return true;
      } else {
        // Sign-up failed
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> addToCart(ProductsModel item) async {
    try {
      final options = Options(headers: {
        'accept': 'application/json',
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      final Map<String, dynamic> requestBody = {
        "name": "user Name",
        "price": item.price!,
        "img":
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
        "quantity": 1,
        "isExist": 'true',
        "product": item.name,
        "time": 2.2,
        "id": 1,
      };
      print(AddToCart);
      var response =
          await _dio.post(AddToCart, data: requestBody, options: options);
      print(response);
      if (response.statusCode == 200) {
        // Successful sign-up
        return true;
      } else {
        // Sign-up failed
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> addOrder({
    required String name,
    required double price,
    required String img,
    required int quantity,
    required String product,
    required double time,
  }) async {
    // try {
    final headers = {
      'accept': 'application/json',
      "ngrok-skip-browser-warning": "69420",
    };
    final Map<String, dynamic> requestBody = {
      "name": name,
      "price": price,
      "img":
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
      "quantity": quantity,
      "isExist": 'true',
      "product": product,
      "status": 'order-placed',
      "time": time,
    };
    final response = await http.post(
      Uri.parse(MAKE_ORDER), // Convert the URL to a Uri object
      headers: headers,
      body: requestBody,
    );

    print(response);
    if (response.statusCode == 200) {
      // Successful order placement
      return true;
    } else {
      // Order placement failed
      return false;
    }
    // } catch (e) {
    //print(e);
    // throw Exception(e);
    // }
  }

  Future<bool> login(String email, String password) async {
    try {
      final headers = {
        'accept': 'application/json',
      };
      final requestBody = {
        "email": email,
        "password": password,
      };
      print(sign_in); // Make sure `sign_in` is defined somewhere
      final response = await http.post(
        Uri.parse(sign_in), // Convert the URL to a Uri object
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Successful sign-in
        var a = jsonDecode(response.body);
        var token = a['token'];
        // Store the token in shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return true;
      } else {
        // Sign-in failed
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  fetchCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // if (token == null) {
      //   throw Exception("Token not found");
      // }

      final options = Options(headers: {
        "ngrok-skip-browser-warning": "69420",
        "accept": "application/json",
        "Authorization": "Bearer $token", // Add bearer token
      });

      final response = await _dio.get(get_cart, options: options);
      final list = List<Cart>.from(response.data.map((x) => Cart.fromMap(x)));
      return list;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
