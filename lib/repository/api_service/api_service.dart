import 'dart:convert';
import 'package:food/modals/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food/modals/product_modals.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../modals/order.dart';

String BASE_URL = 'https://a35d-27-34-17-111.ngrok-free.app';

String IMAGE_URL = BASE_URL + '/images/products/';
String PopularProduct = BASE_URL + '/api/viewproducts_details';
String AddToCart = BASE_URL + '/api/addcart_details';
String deleteCart = BASE_URL + '/api/deletecart_details';
String MAKE_ORDER = BASE_URL + '/api/create-order';
String sign_in = BASE_URL + '/api/login';
String get_cart = BASE_URL + '/api/cart_details';
String get_order = BASE_URL + '/api/individualUserOrders';
String top_selling = BASE_URL = '/topSellingProduct';
String Rating = BASE_URL + '/api/create-rating';

class ApiServices {
  Dio _dio = Dio();
  String apiKey = "990fdcba80304491975861832e86d4aa";
  String? Name;

  Future<Map<String, String>> fetchLocation(
      double latitude, double longitude) async {
    final Uri uri = Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=$apiKey");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final List<dynamic> features = decodedResponse['features'];
        if (features.isNotEmpty) {
          final city = features[0]['properties']['city'];
          final municipality = features[0]['properties']['municipality'];
          return {
            'city': city ?? '',
            'municipality': municipality ?? '',
          };
        } else {
          print("No features found in the response.");
          return {
            'city': '',
            'municipality': '',
          };
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        return {
          'city': '',
          'municipality': '',
        };
      }
    } catch (error) {
      print("Error: $error");
      return {
        'city': '',
        'municipality': '',
      };
    }
  }

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
      print(response.data);
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

  Future<bool> delete_cart(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final options = Options(headers: {
        'accept': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        "Authorization": "Bearer $token",
      });

      var response = await _dio.get(
        BASE_URL + '/api/delete-cart-item/$id',
        options: options,
      );
      print(response);
      if (response.statusCode == 200) {
        var a = response.data;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addToCart(ProductsModel item, int quantity) async {
    try {
      final options = Options(headers: {
        'accept': 'application/json',
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      final Map<String, dynamic> requestBody = {
        "name": "name",
        "price": item.price!,
        "img":
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
        "quantity": 1,
        "isExist": 'true',
        "product": item.name,
        "time": 2.2,
        "id": item.id,
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
      // Calculate the time as a floating-point value
      double timeValue = time.hour.toDouble() + (time.minute.toDouble() / 60.0);
      final Map<String, dynamic> requestBody = {
        "name": name,
        "price": price,
        "quantity": quantity,
        "isExist": true, // Use boolean value instead of string 'true'
        "product": product,
        "status": 1, // Modify as needed
        "time": timeValue, // Convert DateTime to string
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

  Future<bool> rating({
    required double rating,
    required int productid,
    required String message,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final options = BaseOptions(
        baseUrl: Rating, // Replace with your API base URL
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "69420",
          "Authorization": "Bearer $token",
        },
      );

      final dioInstance = Dio(options);
      // Calculate the time as a floating-point value
      final Map<String, dynamic> requestBody = {
        'rating': rating,
        "product_id": productid,
        "message": message,
      };

      final response = await dioInstance.post(
        Rating, // Replace with your specific endpoint
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
