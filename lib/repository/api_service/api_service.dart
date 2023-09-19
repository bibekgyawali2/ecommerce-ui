import 'dart:convert';
import 'package:food/modals/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/modals/product_modals.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../modals/order.dart';

String BASE_URL =
    'https://823d-2400-1a00-bd20-ca2c-cde2-a607-9b56-bbed.ngrok-free.app';

String PopularProduct = BASE_URL + '/api/viewproducts_details';
String AddToCart = BASE_URL + '/api/addcart_details';
String MAKE_ORDER = BASE_URL + '/api/create-order';
String sign_in = BASE_URL + '/api/login';
String get_cart = BASE_URL + '/api/cart_details';
String get_order = BASE_URL + '/api/individualUserOrders';
String top_selling = BASE_URL = '/topSellingProduct';

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

  Future<List<ProductsModel>> topSelling() async {
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

      final response = await _dio.get(top_selling, options: options);
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
    required int quantity,
    required List<int> product,
    required DateTime time,
  }) async {
    try {
      final dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      //final token = "25|XmCFyy4y5EymY45BkDkfyz6L4w4qDK2btCWYclLX";

      final options = BaseOptions(
        baseUrl: MAKE_ORDER, // Replace with your API base URL
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "69420",
          "Authorization": "Bearer $token",
        },
      );

      final dioInstance = Dio(options);

      final Map<String, dynamic> requestBody = {
        "name": name,
        "price": price,
        "quantity": quantity,
        "isExist": true, // Use boolean value instead of string 'true'
        "product": product,
        "status": 'order-placed', // Modify as needed
        "time": 2.2, // Convert DateTime to string
      };

      final response = await dioInstance.post(
        MAKE_ORDER, // Replace with your specific endpoint
        data: requestBody,
      );

      if (response.statusCode == 200) {
        // Successful order placement
        print(response.data);
        return true;
      } else {
        // Order placement failed
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final headers = {
        'accept': 'application/json',
        // "Authorization": "Bearer $token",
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
        await prefs.setString('name', a['user']['name']);
        print(a['user']['name']);
        print(a['user']['email']);
        print(token);
        await prefs.setString('email', a['user']['email']);
        return true;
      } else {
        // Sign-in failed

        return false;
      }
    } catch (e) {
      print(e);
      return false;
      //throw Exception(e);
    }
  }

  fetchCart() async {
    try {
      // if (token == null) {
      //   throw Exception("Token not found");
      // }

      final options = Options(headers: {
        "ngrok-skip-browser-warning": "69420",
        "accept": "application/json",
      });

      final response = await _dio.get(get_cart, options: options);
      final list = List<Cart>.from(response.data.map((x) => Cart.fromMap(x)));
      return list;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  //fetch order
  Future<List<Order>> fetchOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final options = Options(headers: {
        "ngrok-skip-browser-warning": "69420",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      });

      final response = await _dio.get(get_order, options: options);
      final List<dynamic> responseData = response.data['data'];

      // Create a list to store extracted Order objects
      List<Order> orderList = [];

      // Iterate through the response data and extract id and price
      for (var orderData in responseData) {
        final order = Order.fromMap(orderData);
        final id = order.id; // Access the id attribute
        final price = double.parse(order.price); // Parse the price as a double

        // Print or use the id and price as needed
        print('ID: $id');
        print('Price: $price');

        // Add the Order object to the list
        orderList.add(order);
      }

      return orderList;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
