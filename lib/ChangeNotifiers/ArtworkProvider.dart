import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';

class ArtworkProvider extends ChangeNotifier{
  List<ArtworkModel> _artworks = [];
  List<ArtworkModel> get artworks => _artworks;
  ArtworkModel _artwork = ArtworkModel.empty();
  ArtworkModel get artwork => _artwork;
  bool _loaded = false;
  bool get loaded => _loaded;


  Future<dynamic> fetchArtwork() async{
    _loaded = false;
    notifyListeners();
    _artworks = await ArtworkRequest.getAllNonDigitalArtwork();
    _loaded = true;
    notifyListeners();
  }

  Future<dynamic> fetchSingleArtwork(String id) async{
    _loaded = false;
    notifyListeners();
    _artwork = await ArtworkRequest.getArtwork(id);
    _loaded = true;
    notifyListeners();
  }
}