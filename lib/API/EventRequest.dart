import 'ApiManager.dart';
import 'Endpoints.dart';
import 'package:artswindsoressex/Screens/Models/EventModel.dart';

class EventRequest {
  // Method to get current events from the API
  static Future<List<EventDetails>> getCurrentEvents() async {
    // Fetch data from the API using the specified endpoint for current events
    Map<String, dynamic> data =
        await ApiManager.fetchData(toString(Endpoint.GET_EVENT_CURR));
    // Parse the JSON data into a list of EventDetails objects
    List<EventDetails> list = EventDetails.listFromJson(data["data"]);
    return list; // Return the list of current events
  }

  // Method to get past events from the API
  static Future<List<EventDetails>> getPastEvents() async {
    // Fetch data from the API using the specified endpoint for past events
    Map<String, dynamic> data =
        await ApiManager.fetchData(toString(Endpoint.GET_EVENT_PAST));
    // Parse the JSON data into a list of EventDetails objects
    List<EventDetails> list = EventDetails.listFromJson(data["data"]);
    return list; // Return the list of past events
  }
}
