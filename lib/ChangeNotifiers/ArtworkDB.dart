import 'package:flutter/material.dart';
import 'package:artswindsoressex/Database/ArtworkScanned.dart';
import 'package:artswindsoressex/Database/DatabaseHelper.dart';
import 'package:artswindsoressex/Database/TableEnum.dart';

class ArtworkDB extends ChangeNotifier{
  List<ArtworkScanned> _artDB = [];
  List<ArtworkScanned> get artDB => _artDB;
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
}