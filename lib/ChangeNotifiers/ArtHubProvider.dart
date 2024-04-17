import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart'; // Importing ArtworkModel class for artwork data
import 'package:artswindsoressex/API/ArtworkRequest.dart'; // Importing ArtworkRequest class for API requests

class ArtHubProvider extends ChangeNotifier {
  List<ArtworkModel> _artHub = []; // List to store artwork data
  List<ArtworkModel> get artHub => _artHub; // Getter for artwork list
  bool _loaded = false; // Flag to indicate if data is loaded
  bool get loaded => _loaded; // Getter for data load status

  // Method to fetch artwork data
  Future<dynamic> fetchArtHub() async {
    _loaded = false; // Set data load status to false
    notifyListeners(); // Notify listeners of data change
    _artHub = await ArtworkRequest
        .getAllArtworks(); // Fetch artwork data using API request
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }
}
