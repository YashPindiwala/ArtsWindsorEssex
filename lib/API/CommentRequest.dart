import 'package:artswindsoressex/Screens/Models/CommentModel.dart';
import 'package:artswindsoressex/API/ApiManager.dart';
import 'package:artswindsoressex/API/Endpoints.dart';

class CommentRequest{
  static Future<bool> postComment(CommentModel comment) async {
    print(comment.toJson());
    var response = await ApiManager.post(toString(Endpoint.POST_COMMENT), comment.toJson());
    return response;
  }
}