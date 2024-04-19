import 'LocationModel.dart';
import 'ArtistModel.dart';
import 'TagModel.dart';
import 'UploadModel.dart';
import 'dart:ui';
import '../../constants.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ArtworkModel {
  int artwork_id = 0;
  String title = "";
  String description = "";
  String image = "";
  LocationDetails location = LocationDetails.empty();
  ArtistModel artist = ArtistModel.empty();
  List<TagModel> tags = [];
  List<UploadModel> uploads = [];
  Color cardColor = orangeColor;
  Color titleColor = orangeColor;
  bool comments_disabled = false;
  bool upload_disabled = false;
  bool is_digital = false;
  static int colorIndex = 0;
  static final BitmapDescriptor orangeMarker = BitmapDescriptor.defaultMarkerWithHue(30);
  static final BitmapDescriptor greyMarker = BitmapDescriptor.defaultMarkerWithHue(150);

  ArtworkModel.empty();

  ArtworkModel({
    required this.artwork_id,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.artist,
    required this.tags,
    required this.uploads,
    required this.comments_disabled,
    required this.upload_disabled,
    required this.is_digital,
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
          .map((tag) => TagModel(tag: tag['tag'] ?? '',id: tag['id']))
          .toList();
    }
    List<UploadModel> uploadList = [];
    if (json['uploads'] != null) {
      uploadList = (json['uploads'] as List)
          .map((upload) => UploadModel(image: upload['image'], title: upload['title'], approved: upload['approved'], visible: upload['visible']))
          .toList();
    }
    return ArtworkModel(
      artwork_id: json['artwork_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: new LocationDetails(title: json["title"] ?? "", latitude: location["lat"] ?? "", longitude: location["long"] ?? ""),
      artist: new ArtistModel(firstName: json['artist']['first_name'] ?? "", lastName: json['artist']['last_name'] ?? ""),
      tags: tagsList,
      uploads: uploadList,
      comments_disabled: json["comments_disabled"],
      upload_disabled: json["upload_disabled"],
      is_digital: json["is_digital"],
      cardColor: card,
      titleColor: title,
    );
  }

  static List<ArtworkModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
