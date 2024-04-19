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
  bool _error = false;
  bool get error => _error;


  Future<dynamic> fetchArtwork() async{
    _loaded = false;
    notifyListeners();
    _artworks = await ArtworkRequest.getAllNonDigitalArtwork();
    _loaded = true;
    notifyListeners();
  }

  Future<void> fetchSingleArtwork(String id) async {
    _loaded = false;
    _error = false; // Reset error state
    notifyListeners();
    try {
      _artwork = await ArtworkRequest.getArtwork(id);
    } catch (e) {
      // Handle error
      _error = true;
      print('Error fetching single artwork: $e');
    }
    _loaded = true;
    notifyListeners();
  }
}