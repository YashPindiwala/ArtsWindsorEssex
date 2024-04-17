class ArtworkTag {
  final int id; // ID of the artwork-tag relationship
  final int artworkId; // ID of the artwork
  final int tagId; // ID of the tag

  // Constructor for creating an ArtworkTag instance
  ArtworkTag({
    required this.id,
    required this.artworkId,
    required this.tagId,
  });

  // Factory method to create an ArtworkTag instance from a map
  factory ArtworkTag.fromMap(Map<String, dynamic> map) {
    return ArtworkTag(
      id: map['id'], // Initialize id from the map
      artworkId: map['artwork_id'], // Initialize artworkId from the map
      tagId: map['tag_id'], // Initialize tagId from the map
    );
  }

  // Method to convert ArtworkTag instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add id to the map
      'artwork_id': artworkId, // Add artworkId to the map
      'tag_id': tagId, // Add tagId to the map
    };
  }
}
