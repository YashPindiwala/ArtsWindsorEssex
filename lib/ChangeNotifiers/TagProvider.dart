import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/API/TagRequest.dart';

class TagProvider extends ChangeNotifier{
  List<TagModel> _tags = [];
  List<TagModel> get tags => _tags;
  bool _loaded = false;
  bool get loaded => _loaded;

  Future<dynamic> fetchTags() async{
    _loaded = false;
    notifyListeners();
    _tags = await TagRequest.getAllTags();
    _loaded = true;
    notifyListeners();
  }
}