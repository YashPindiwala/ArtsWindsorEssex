import 'ApiManager.dart';
import 'Endpoints.dart';

class ArtworkRequest{
  static Future<dynamic> getAllArtworks() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_ARTWORK_ALL));
    return data["data"];
    // return data["data"];
  }
  static Future<dynamic> getAllNonDigitalArtwork() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_ARTWORK_NOT_DIGITAL));
    return data["data"];
    // return data["data"];
  }
}