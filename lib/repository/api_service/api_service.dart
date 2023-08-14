import 'dart:convert';

import 'package:food/modals/product_modals.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String BASE_URL = 'https://484c-103-134-216-146.ngrok-free.app';

String PopularProduct = BASE_URL + '/api/viewproducts_details';
String AddToCart = BASE_URL + '/addcart_details';
String MAKE_ORDER = BASE_URL + '/addorder_detail';

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

  Future<bool> signUp(
      String fName, String email, String password, String phone) async {
    try {
      final options = Options(headers: {
        'accept': 'application/json',
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      final Map<String, dynamic> requestBody = {
        'f_name': fName,
        'f_email': email,
        'f_password': password,
        'f_phone': phone,
      };
      var response = await _dio.post(BASE_URL + '/api/addsignup',
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
        "price": item.price,
        "img":
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
        "quantity": 1,
        "isExist": true,
        "product": item.name,
        "time": DateTime.now()
      };
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

  Future<bool> addOrder(ProductsModel item) async {
    try {
      final options = Options(headers: {
        'accept': 'application/json',
        // Add your headers here
        "ngrok-skip-browser-warning": "69420",
      });
      final Map<String, dynamic> requestBody = {
        "name": "user Name",
        "price": item.price,
        "img":
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
        "quantity": 1,
        "isExist": true,
        "product": item.name,
        "status": 'order-placed',
        "time": DateTime.now()
      };
      var response =
          await _dio.post(MAKE_ORDER, data: requestBody, options: options);
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
}
