import 'LocationModel.dart'; // Importing LocationModel.dart for LocationDetails
import 'ArtistModel.dart'; // Importing ArtistModel.dart for ArtistModel
import 'TagModel.dart'; // Importing TagModel.dart for TagModel
import 'UploadModel.dart'; // Importing UploadModel.dart for UploadModel
import 'dart:ui'; // Importing dart:ui for Color class (Consider removing if not used)
import '../../constants.dart'; // Importing constants.dart for orangeColor and listOfColors
import 'dart:math'; // Importing dart:math for Random class (Consider removing if not used)
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Importing google_maps_flutter for BitmapDescriptor class

class ArtworkModel {
  int artwork_id = 0; // The ID of the artwork
  String title = ""; // The title of the artwork
  String description = ""; // The description of the artwork
  String image = ""; // The URL of the artwork image
  LocationDetails location =
      LocationDetails.empty(); // The location details of the artwork
  ArtistModel artist = ArtistModel.empty(); // The artist details of the artwork
  List<TagModel> tags = []; // The list of tags associated with the artwork
  List<UploadModel> uploads =
      []; // The list of uploads associated with the artwork
  Color cardColor =
      orangeColor; // The color of the card representing the artwork (default: orange)
  Color titleColor =
      orangeColor; // The color of the title representing the artwork (default: orange)
  bool comments_disabled =
      false; // Flag indicating whether comments are disabled for the artwork
  bool upload_disabled =
      false; // Flag indicating whether uploads are disabled for the artwork
  bool is_digital = false; // Flag indicating whether the artwork is digital
  static int colorIndex = 0; // Static variable to track the index of colors
  static final BitmapDescriptor orangeMarker =
      BitmapDescriptor.defaultMarkerWithHue(30); // Marker for the map (orange)
  static final BitmapDescriptor greyMarker =
      BitmapDescriptor.defaultMarkerWithHue(150); // Marker for the map (grey)

  ArtworkModel.empty(); // Empty constructor for creating an empty artwork model

  ArtworkModel({
    // Constructor for creating an artwork model with provided values
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
    // Factory method to create an artwork model from JSON data
    if (colorIndex >= listOfColors.length) colorIndex = 0;

    Color card = listOfColors[colorIndex]
        ["card"]!; // Getting card color from the list of colors
    Color title = listOfColors[colorIndex]
        ["title"]!; // Getting title color from the list of colors
    colorIndex++;
    var location = json["location"];
    List<TagModel> tagsList = [];
    if (json['tags'] != null) {
      tagsList = (json['tags'] as List)
          .map((tag) => TagModel(tag: tag['tag'] ?? '', id: tag['id']))
          .toList(); // Mapping JSON tag data to TagModel objects
    }
    List<UploadModel> uploadList = [];
    if (json['uploads'] != null) {
      uploadList = (json['uploads'] as List)
          .map((upload) => UploadModel(image: upload['image']))
          .toList(); // Mapping JSON upload data to UploadModel objects
    }
    return ArtworkModel(
      artwork_id: json['artwork_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: new LocationDetails(
          title: json["title"] ?? "",
          latitude: location["lat"] ?? "",
          longitude: location["long"] ?? ""),
      artist: new ArtistModel(
          firstName: json['artist']['first_name'] ?? "",
          lastName: json['artist']['last_name'] ?? ""),
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
    // Method to create a list of artwork models from a JSON list
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
