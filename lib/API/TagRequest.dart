import 'ApiManager.dart';
import 'Endpoints.dart';

class TagRequest{
  static Future<dynamic> getAllTags() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_TAGS));
    return data["data"];
  }
}