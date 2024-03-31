import 'LocationModel.dart';
import 'ArtistModel.dart';
import 'dart:ui';
import '../../constants.dart';
import 'dart:math';

class ArtworkModel {
  final String title;
  final String description;
  final String image;
  final LocationDetails location;
  final ArtistModel artist;
  final Color cardColor;
  final Color titleColor;
  static int colorIndex = 0;

  ArtworkModel({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.artist,
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
    return ArtworkModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: new LocationDetails(title: json["title"] ?? "", latitude: location["lat"] ?? "", longitude: location["long"] ?? ""),
      artist: new ArtistModel(firstName: json['first_name'] ?? "", lastName: json['last_name'] ?? ""),
      cardColor: card,
      titleColor: title,

    );
  }

  static List<ArtworkModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
