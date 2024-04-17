import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:artswindsoressex/Screens/Models/EventModel.dart'; // Importing EventModel class for event data
import 'package:artswindsoressex/API/EventRequest.dart'; // Importing EventRequest class for API requests

class EventProvider extends ChangeNotifier {
  List<EventDetails> _eventsCurr = []; // List to store current events
  List<EventDetails> get eventsCurr =>
      _eventsCurr; // Getter for current events list

  List<EventDetails> _eventsPast = []; // List to store past events
  List<EventDetails> get eventsPast =>
      _eventsPast; // Getter for past events list

  bool _loaded = false; // Flag to indicate if data is loaded
  bool get loaded => _loaded; // Getter for data load status

  // Method to fetch current events
  Future<dynamic> fetchCurrEvents() async {
    _loaded = false; // Set data load status to false
    notifyListeners(); // Notify listeners of data change
    _eventsCurr = await EventRequest
        .getCurrentEvents(); // Fetch current events using API request
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }

  // Method to fetch past events
  Future<dynamic> fetchPastEvents() async {
    _loaded = false; // Set data load status to false
    notifyListeners(); // Notify listeners of data change
    _eventsPast = await EventRequest
        .getPastEvents(); // Fetch past events using API request
    _loaded = true; // Set data load status to true
    notifyListeners(); // Notify listeners of data change
  }
}
