class TagModel {
  final String tag;

  TagModel({
    required this.tag,
  });

  TagModel.empty()
      : tag = 'Unknown';


  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tag: json['tag'] ?? '',
    );
  }

  static List<TagModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => TagModel.fromJson(json)).toList();
  }
}
