import 'LocationModel.dart';
class ArtworkModel {
  final String title;
  final String description;
  final String image;
  final LocationDetails location;

  ArtworkModel({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    var location = json["location"];
    return ArtworkModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: new LocationDetails(title: json["title"] ?? "", latitude: location["lat"] ?? "", longitude: location["long"] ?? ""),
    );
  }

  static List<ArtworkModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
