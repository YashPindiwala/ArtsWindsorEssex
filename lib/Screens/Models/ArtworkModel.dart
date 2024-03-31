import 'LocationModel.dart';
import 'ArtistModel.dart';
import 'TagModel.dart';
import 'dart:ui';
import '../../constants.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ArtworkModel {
  final String title;
  final String description;
  final String image;
  final LocationDetails location;
  final ArtistModel artist;
  final List<TagModel> tags;
  final Color cardColor;
  final Color titleColor;
  static int colorIndex = 0;
  static final BitmapDescriptor orangeMarker = BitmapDescriptor.defaultMarkerWithHue(30);
  static final BitmapDescriptor greyMarker = BitmapDescriptor.defaultMarkerWithHue(150);

  ArtworkModel({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.artist,
    required this.tags,
    required this.cardColor,
    required this.titleColor,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    if(colorIndex >= listOfColors.length)
      colorIndex = 0;

    Color card = listOfColors[colorIndex]["card"]!;
    Color title = listOfColors[colorIndex]["title"]!;
    colorIndex++;
    var location = json["location"];
    List<TagModel> tagsList = [];
    if (json['tags'] != null) {
      tagsList = (json['tags'] as List)
          .map((tag) => TagModel(tag: tag['tag'] ?? ''))
          .toList();
    }
    return ArtworkModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: new LocationDetails(title: json["title"] ?? "", latitude: location["lat"] ?? "", longitude: location["long"] ?? ""),
      artist: new ArtistModel(firstName: json['first_name'] ?? "", lastName: json['last_name'] ?? ""),
      tags: tagsList,
      cardColor: card,
      titleColor: title,
    );
  }

  static List<ArtworkModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
