import 'ApiManager.dart';
import 'Endpoints.dart';

class TransactionRequest{
  static void postTransaction(String artwork_id) async {
    String artworkId = artwork_id;
    Map<String, dynamic> jsonData = {
      'artwork_id': artworkId,
    };
    await ApiManager.post(toString(Endpoint.POST_TRANSACTION),jsonData);
  }
}