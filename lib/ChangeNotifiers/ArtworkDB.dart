import 'package:flutter/material.dart';
import 'package:artswindsoressex/Database/ArtworkScanned.dart';
import 'package:artswindsoressex/Database/DatabaseHelper.dart';
import 'package:artswindsoressex/Database/TableEnum.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';

class ArtworkDB extends ChangeNotifier{
  List<ArtworkScanned> _artDB = [];
  List<ArtworkScanned> get artDB => _artDB;
  List<TagModel> _tagDB = [];
  List<TagModel> get tagDB => _tagDB;
  TagModel? _selectedTag;
  TagModel? get selectedTag => _selectedTag;
  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> fetchArtDB() async {
    _loaded = false;
    notifyListeners();
    try {
      List<Map<String, dynamic>> artworksData = await DatabaseHelper().getAllData(TableName.ArtworkScanned);
      _artDB = artworksData.map((map) => ArtworkScanned.fromMap(map)).toList();
    } catch (e) {
      // Handle error
      print('Error fetching artworks from database: $e');
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> fetchTagDB() async {
    _loaded = false;
    notifyListeners();
    try {
      List<Map<String, dynamic>> artworksData = await DatabaseHelper().getAllData(TableName.Tag);
      _tagDB = artworksData.map((map) => TagModel.fromMap(map)).toList();
      _tagDB.sort((a, b) => a.tag.compareTo(b.tag));
    } catch (e) {
      // Handle error
      print('Error fetching artworks from database: $e');
    }
    _loaded = true;
    notifyListeners();
  }

  void selectTag(TagModel tag) {
    _selectedTag = tag;
    notifyListeners();
  }
}