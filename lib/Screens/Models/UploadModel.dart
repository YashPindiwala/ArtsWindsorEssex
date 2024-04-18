class UploadModel {
  final String image;

  UploadModel({required this.image});

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      image: json['image'],
    );
  }

  static List<UploadModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UploadModel.fromJson(json)).toList();
  }
}
