class UploadModel {
  final String image;
  final String title;

  UploadModel({required this.image,required this.title});

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      image: json['image'],
      title: json['title'],
    );
  }

  static List<UploadModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UploadModel.fromJson(json)).toList();
  }
}
