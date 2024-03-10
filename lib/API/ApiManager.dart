import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ApiManager{
  static const String baseUrl = 'https://ypindiwala.scweb.ca/AWEWebApp/api/';

  static Future<dynamic> fetchData(String endPoint) async {
    await dotenv.load();
    // await Future.delayed(Duration(seconds: 2));
    try {
      var response = await http.get(
          Uri.parse(baseUrl + endPoint),
          headers: {
            "x-api-key" : dotenv.env["API_KEY"] ?? "",
          }
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}