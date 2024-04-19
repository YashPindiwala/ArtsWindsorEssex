import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/EventModel.dart';
import 'package:artswindsoressex/API/EventRequest.dart';

class EventProvider extends ChangeNotifier{
  List<EventDetails> _eventsCurr = [];
  List<EventDetails> get eventsCurr => _eventsCurr;
  List<EventDetails> _eventsPast = [];
  List<EventDetails> get eventsPast => _eventsPast;
  bool _loaded = false;
  bool get loaded => _loaded;

  Future<dynamic> fetchCurrEvents() async{
    _loaded = false;
    notifyListeners();
    _eventsCurr = await EventRequest.getCurrentEvents();
    _loaded = true;
    notifyListeners();
  }
  Future<dynamic> fetchPastEvents() async{
    _loaded = false;
    notifyListeners();
    _eventsPast = await EventRequest.getPastEvents();
    _loaded = true;
    notifyListeners();
  }
}