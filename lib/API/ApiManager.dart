import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:artswindsoressex/Screens/Models/UserUpload.dart';

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

  static Future<bool> post(String endPoint, dynamic data) async {
    await dotenv.load();
    // await Future.delayed(Duration(seconds: 2));
    try {
      var response = await http.post(
          Uri.parse(baseUrl + endPoint),
          headers: {
            "x-api-key" : dotenv.env["API_KEY"] ?? "",
            "Content-Type" : "application/json",
          },
          body: jsonEncode(data)
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to connect to the server $e');
    }
  }

  static Future<bool> uploadImage(UserUpload userUpload) async {
    await dotenv.load();
    try {
      var uri = Uri.parse(baseUrl + "uploads");
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "x-api-key" : dotenv.env["API_KEY"] ?? "",
        "Content-Type" : "application/json",
      });
      request.fields['artwork_id'] = userUpload.artworkId.toString();
      request.fields['title'] = userUpload.title;
      request.fields['description'] = userUpload.description;

      var file = await http.MultipartFile.fromPath('image', userUpload.filePath);
      request.files.add(file);

      var response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error uploading image: $error');
      return false;
    }
  }



}