import 'ApiManager.dart';
import 'Endpoints.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';

class TagRequest{
  static Future<List<TagModel>> getAllTags() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_TAGS));
    List<TagModel> list = TagModel.listFromJson(data["data"]);
    return list;
  }
}