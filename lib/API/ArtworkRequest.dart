import 'ApiManager.dart'; // Importing the ApiManager class for making API requests
import 'Endpoints.dart'; // Importing the Endpoints file for endpoint URLs
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart'; // Importing the ArtworkModel class for artwork data

class ArtworkRequest {
  // Method to get all artworks from the API
  static Future<List<ArtworkModel>> getAllArtworks() async {
    // Fetch data from the API using the specified endpoint
    Map<String, dynamic> data =
        await ApiManager.fetchData(Endpoint.GET_ARTWORK_ALL.toString());
    // Parse the JSON data into a list of ArtworkModel objects
    List<ArtworkModel> list = ArtworkModel.listFromJson(data["data"]);
    return list; // Return the list of artworks
  }

  // Method to get all non-digital artworks from the API
  static Future<List<ArtworkModel>> getAllNonDigitalArtwork() async {
    // Fetch data from the API using the specified endpoint
    Map<String, dynamic> data =
        await ApiManager.fetchData(Endpoint.GET_ARTWORK_NOT_DIGITAL.toString());
    // Parse the JSON data into a list of ArtworkModel objects
    List<ArtworkModel> list = ArtworkModel.listFromJson(data["data"]);
    return list; // Return the list of non-digital artworks
  }

  // Method to get a specific artwork by its ID from the API
  static Future<ArtworkModel> getArtwork(String id) async {
    // Fetch data from the API using the specified endpoint and artwork ID
    Map<String, dynamic> data =
        await ApiManager.fetchData(Endpoint.GET_ARTWORK.toString() + id);
    // Parse the JSON data into an ArtworkModel object
    ArtworkModel artworkModel = ArtworkModel.fromJson(data["data"]);
    return artworkModel; // Return the artwork model
  }
}
