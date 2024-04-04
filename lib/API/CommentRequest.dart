import 'package:artswindsoressex/Screens/Models/CommentModel.dart';
import 'package:artswindsoressex/API/ApiManager.dart';
import 'package:artswindsoressex/API/Endpoints.dart';

class CommentRequest{
  static Future<bool> postComment(CommentModel comment) async {
    var response = await ApiManager.post(toString(Endpoint.POST_COMMENT), comment.toJson());
    return response;
  }
  static Future<List<CommentModel>> getRelatedComments(String artwork_id) async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_COMMENT) + artwork_id);
    List<CommentModel> list = CommentModel.listFromJson(data['data']);
    return list;
  }
}