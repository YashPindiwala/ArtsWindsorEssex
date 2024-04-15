class Tag {
  final int id;
  final String tag;

  Tag({
    required this.id,
    required this.tag,
  });

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      tag: map['tag'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
    };
  }
}