class TagModel {
  final String tag;
  final int id;

  TagModel({
    required this.tag,
    required this.id
  });

  TagModel.empty()
      : tag = 'Unknown',id = 0;


  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tag: json['tag'] ?? '',
      id: json['id']
    );
  }

  static List<TagModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => TagModel.fromJson(json)).toList();
  }
}
