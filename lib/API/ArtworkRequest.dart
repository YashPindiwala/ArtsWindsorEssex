import 'ApiManager.dart';
import 'Endpoints.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';

class ArtworkRequest{
  static Future<List<ArtworkModel>> getAllArtworks() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_ARTWORK_ALL));
    List<ArtworkModel> list = ArtworkModel.listFromJson(data["data"]);
    return list;
  }
  static Future<dynamic> getAllNonDigitalArtwork() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_ARTWORK_NOT_DIGITAL));
    return data["data"];
    // return data["data"];
  }
}