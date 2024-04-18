import 'ApiManager.dart'; // Importing the ApiManager class for making API requests
import 'Endpoints.dart'; // Importing the Endpoints file for endpoint URLs
import 'dart:convert'; // Importing the dart:convert library for JSON encoding and decoding

class TransactionRequest {
  // Method to post a transaction to the API
  static void postTransaction(String artwork_id) async {
    // Extract artwork ID from the parameter
    String artworkId = artwork_id;
    // Create a JSON object containing artwork ID
    Map<String, dynamic> jsonData = {
      'artwork_id': artworkId,
    };
    // Make a POST request to the API to post the transaction
    await ApiManager.post(Endpoint.POST_TRANSACTION.toString(), jsonData);
  }
}
