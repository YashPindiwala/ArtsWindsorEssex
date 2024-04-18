import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';

class ArtHubProvider extends ChangeNotifier{
  List<ArtworkModel> _artHub = [];
  List<ArtworkModel> get artHub => _artHub;
  bool _loaded = false;
  bool get loaded => _loaded;

  Future<dynamic> fetchArtHub() async{
    _loaded = false;
    notifyListeners();
    _artHub = await ArtworkRequest.getAllArtworks();
    _loaded = true;
    notifyListeners();
  }
}