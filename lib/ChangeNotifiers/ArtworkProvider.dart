import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart'; // Importing ArtworkModel class for artwork data
import 'package:artswindsoressex/API/ArtworkRequest.dart'; // Importing ArtworkRequest class for API requests

class ArtworkProvider extends ChangeNotifier {
  List<ArtworkModel> _artworks = []; // List to store artwork data
  List<ArtworkModel> get artworks => _artworks; // Getter for artwork list

  ArtworkModel _artwork =
      ArtworkModel.empty(); // Placeholder for a single artwork
  ArtworkModel get artwork => _artwork; // Getter for single artwork

  bool _loaded = false; // Flag to indicate if data is loaded
  bool get loaded => _loaded; // Getter for data load status

  bool _error = false; // Flag to indicate if an error occurred
  bool get error => _error; // Getter for error status

  // Method to fetch all non-digital artworks
  Future<dynamic> fetchArtwork() async {
    _loaded = false; // Set data load status to false
    notifyListeners(); // Notify listeners of data change
    _artworks = await ArtworkRequest
        .getAllNonDigitalArtwork(); // Fetch non-digital artworks using API request
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }

  // Method to fetch a single artwork by its ID
  Future<void> fetchSingleArtwork(String id) async {
    _loaded = false; // Set data load status to false
    _error = false; // Reset error state
    notifyListeners(); // Notify listeners of data change
    try {
      _artwork = await ArtworkRequest.getArtwork(
          id); // Fetch single artwork using API request
    } catch (e) {
      // Handle error if fetching data fails
      _error = true; // Set error state to true
      print('Error fetching single artwork: $e'); // Print error message
    }
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }
}
