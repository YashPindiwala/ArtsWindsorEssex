class UploadModel {
  final String image; // The image path

  UploadModel({
    required this.image, // Constructor to initialize the image path
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      image: json['image'] ?? '', // Extracting image path from JSON
    );
  }

  static List<UploadModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UploadModel.fromJson(json)).toList();
  }
}
