class ArtworkTag {
  final int id;
  final int artworkId;
  final int tagId;

  ArtworkTag({
    required this.id,
    required this.artworkId,
    required this.tagId,
  });

  factory ArtworkTag.fromMap(Map<String, dynamic> map) {
    return ArtworkTag(
      id: map['id'],
      artworkId: map['artwork_id'],
      tagId: map['tag_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artwork_id': artworkId,
      'tag_id': tagId,
    };
  }
}
