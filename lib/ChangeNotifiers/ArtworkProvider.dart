import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';

class ArtworkProvider extends ChangeNotifier{
  List<ArtworkModel> _artworks = [];
  List<ArtworkModel> get artworks => _artworks;
  bool _loaded = false;
  bool get loaded => _loaded;


  Future<dynamic> fetchArtwork() async{
    _loaded = false;
    notifyListeners();
    _artworks = await ArtworkRequest.getAllNonDigitalArtwork();
    _loaded = true;
    notifyListeners();
  }
}