class TagModel {
  final String tag; // The name of the tag
  final int id; // The ID of the tag

  TagModel({
    required this.tag,
    required this.id,
  });

  TagModel.empty()
      : tag = 'Unknown',
        id = 0;

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tag: json['tag'] ?? '', // Extracting tag name from JSON
      id: json['id'] ?? 0, // Extracting tag ID from JSON
    );
  }

  static List<TagModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => TagModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'tag': tag, // Storing tag name in a map
      'id': id, // Storing tag ID in a map
    };
  }
}
