import 'ApiManager.dart';
import 'Endpoints.dart';

class EventRequest{
  static Future<dynamic> getCurrentEvents() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_EVENT_CURR));
    return data["data"];
    // return data["data"];
  }
  static Future<dynamic> getPastEvents() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_EVENT_PAST));
    return data["data"];
    // return data["data"];
  }
}