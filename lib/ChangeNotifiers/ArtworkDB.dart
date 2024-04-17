import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:artswindsoressex/Database/ArtworkScanned.dart'; // Importing ArtworkScanned class for scanned artwork data
import 'package:artswindsoressex/Database/DatabaseHelper.dart'; // Importing DatabaseHelper class for interacting with the database
import 'package:artswindsoressex/Database/TableEnum.dart'; // Importing TableName enum for table names

class ArtworkDB extends ChangeNotifier {
  List<ArtworkScanned> _artDB = []; // List to store scanned artwork data
  List<ArtworkScanned> get artDB => _artDB; // Getter for scanned artwork list
  bool _loaded = false; // Flag to indicate if data is loaded
  bool get loaded => _loaded; // Getter for data load status

  // Method to fetch scanned artwork data from the database
  Future<void> fetchArtDB() async {
    _loaded = false; // Set data load status to false
    notifyListeners(); // Notify listeners of data change
    try {
      // Fetch all scanned artwork data from the database
      List<Map<String, dynamic>> artworksData =
          await DatabaseHelper().getAllData(TableName.ArtworkScanned);
      // Convert fetched data into ArtworkScanned objects and assign to _artDB list
      _artDB = artworksData.map((map) => ArtworkScanned.fromMap(map)).toList();
    } catch (e) {
      // Handle error if fetching data fails
      print('Error fetching artworks from database: $e');
    }
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }
}
