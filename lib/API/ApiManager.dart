import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:artswindsoressex/Screens/Models/UserUpload.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ApiManager {
  // Base URL for API endpoints
  static const String baseUrl = 'https://ypindiwala.scweb.ca/AWEWebApp/api/';

  // Method to fetch data from the API
  static Future<dynamic> fetchData(String endPoint) async {
    // Load environment variables
    await dotenv.load();

    // Make HTTP GET request
    try {
      var response = await http.get(Uri.parse(baseUrl + endPoint), headers: {
        "x-api-key":
            dotenv.env["API_KEY"] ?? "", // API key from environment variables
      });

      // Check if request was successful
      if (response.statusCode == 200) {
        // Decode JSON response and return
        return jsonDecode(response.body);
      } else {
        // Throw exception if request failed
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Throw exception if failed to connect to server
      throw Exception('Failed to connect to the server');
    }
  }

  // Method to make a POST request to the API
  static Future<bool> post(String endPoint, dynamic data) async {
    // Load environment variables
    await dotenv.load();

    // Make HTTP POST request
    try {
      var response = await http.post(Uri.parse(baseUrl + endPoint),
          headers: {
            "x-api-key": dotenv.env["API_KEY"] ??
                "", // API key from environment variables
            "Content-Type": "application/json",
          },
          body: jsonEncode(data));

      // Check if request was successful
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Throw exception if failed to connect to server
      throw Exception('Failed to connect to the server $e');
    }
  }

  // Method to upload an image to the API
  static Future<bool> uploadImage(
      BuildContext context, UserUpload userUpload) async {
    // Load environment variables
    await dotenv.load();

    try {
      // Check file size
      var fileSize = await File(userUpload.filePath).length();
      if (fileSize > 2 * (1024 * 1024)) {
        // Show error dialog if file size exceeds limit
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

      // Create multipart request
      var uri = Uri.parse(baseUrl + "uploads");
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "x-api-key":
            dotenv.env["API_KEY"] ?? "", // API key from environment variables
        "Content-Type": "application/json",
      });
      request.fields['artwork_id'] = userUpload.artworkId.toString();
      request.fields['title'] = userUpload.title;
      request.fields['description'] = userUpload.description;
      request.fields['tags'] =
          userUpload.tags.map((tag) => tag.id.toString()).join(',');

      // Attach image file to request
      var file =
          await http.MultipartFile.fromPath('image', userUpload.filePath);
      request.files.add(file);

      // Send request
      var response = await request.send();

      // Check if request was successful
      if (response.statusCode == 201) {
        return true;
      } else {
        // Print error message if upload failed
        print('Failed to upload image. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Print error message if upload failed
      print('Error uploading image: $error');
      return false;
    }
  }
}
