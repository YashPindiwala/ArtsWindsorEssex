class UploadModel {
  final String image;
  final String title;
  final bool approved;
  final bool visible;

  UploadModel({required this.image,required this.title, required this.approved, required this.visible});

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      image: json['image'],
      title: json['title'],
      approved: json['approved'],
      visible: json['visible'],
    );
  }

  static List<UploadModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UploadModel.fromJson(json)).toList();
  }
}
