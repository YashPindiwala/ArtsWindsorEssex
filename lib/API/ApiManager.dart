import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:artswindsoressex/Screens/Models/UserUpload.dart';
import 'dart:io';
import 'package:flutter/material.dart';

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

  static Future<bool> uploadImage(BuildContext context, UserUpload userUpload) async {
    await dotenv.load();
    try {
      var fileSize = await File(userUpload.filePath).length();
      if (fileSize > 2 * (1024 * 1024)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('File size exceeds the limit (2MB).'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return false;
      }


      var uri = Uri.parse(baseUrl + "uploads");
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "x-api-key" : dotenv.env["API_KEY"] ?? "",
        "Content-Type" : "application/json",
      });
      request.fields['artwork_id'] = userUpload.artworkId.toString();
      request.fields['title'] = userUpload.title;
      request.fields['description'] = userUpload.description;
      request.fields['tags'] = userUpload.tags.map((tag) => tag.id.toString()).join(',');

      var file = await http.MultipartFile.fromPath('image', userUpload.filePath);
      request.files.add(file);

      var response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }



}