import 'ApiManager.dart';
import 'Endpoints.dart';
import 'package:artswindsoressex/Screens/Models/EventModel.dart';

class EventRequest{
  static Future<List<EventDetails>> getCurrentEvents() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_EVENT_CURR));
    List<EventDetails> list = EventDetails.listFromJson(data["data"]);
    return list;
  }
  static Future<List<EventDetails>> getPastEvents() async {
    Map<String, dynamic> data = await ApiManager.fetchData(toString(Endpoint.GET_EVENT_PAST));
    List<EventDetails> list = EventDetails.listFromJson(data["data"]);
    return list;
  }
}