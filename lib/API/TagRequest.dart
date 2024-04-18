import 'ApiManager.dart'; // Importing the ApiManager class for making API requests
import 'Endpoints.dart'; // Importing the Endpoints file for endpoint URLs
import 'package:artswindsoressex/Screens/Models/TagModel.dart'; // Importing the TagModel class for tag data

class TagRequest {
  // Method to get all tags from the API
  static Future<List<TagModel>> getAllTags() async {
    // Fetch data from the API using the specified endpoint for tags
    Map<String, dynamic> data =
        await ApiManager.fetchData(toString(Endpoint.GET_TAGS));
    // Parse the JSON data into a list of TagModel objects
    List<TagModel> list = TagModel.listFromJson(data["data"]);
    return list; // Return the list of tags
  }
}
