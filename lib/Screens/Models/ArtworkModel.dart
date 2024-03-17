class ArtworkModel {
  final String title;
  final String description;
  final String image;

  ArtworkModel({
    required this.title,
    required this.description,
    required this.image,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  static List<ArtworkModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtworkModel.fromJson(json)).toList();
  }
}
