import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<String> fetchData(latitude, longitude) async {
    final String apiKey = "990fdcba80304491975861832e86d4aa";

    final Uri uri = Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=$apiKey");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        print(decodedResponse);
        return decodedResponse;
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        return "";
      }
    } catch (error) {
      print("Error: $error");
      return error.toString();
    }
  }
}
