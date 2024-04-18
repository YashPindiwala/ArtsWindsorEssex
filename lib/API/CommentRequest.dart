import 'package:artswindsoressex/Screens/Models/CommentModel.dart'; // Importing CommentModel class for comment data
import 'package:artswindsoressex/API/ApiManager.dart'; // Importing ApiManager class for making API requests
import 'package:artswindsoressex/API/Endpoints.dart'; // Importing Endpoints file for endpoint URLs

class CommentRequest {
  // Method to post a comment to the API
  static Future<bool> postComment(CommentModel comment) async {
    // Make a POST request to the API to post the comment
    var response = await ApiManager.post(
        Endpoint.POST_COMMENT.toString(), comment.toJson());
    return response; // Return the response status
  }

  // Method to get comments related to a specific artwork from the API
  static Future<List<CommentModel>> getRelatedComments(
      String artwork_id) async {
    // Fetch data from the API using the specified endpoint and artwork ID
    Map<String, dynamic> data = await ApiManager.fetchData(
        Endpoint.GET_COMMENT.toString() + artwork_id);
    // Parse the JSON data into a list of CommentModel objects
    List<CommentModel> list = CommentModel.listFromJson(data['data']);
    return list; // Return the list of related comments
  }
}
