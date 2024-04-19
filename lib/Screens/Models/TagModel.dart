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

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
      'id': id,
    };
  }

  factory TagModel.fromMap(Map<String, dynamic> map) {
    return TagModel(
      id: map['id'],
      tag: map['tag']
    );
  }
  @override
  toString(){
    return this.tag;
  }
}
