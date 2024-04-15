class ArtworkScanned {
  final int id;
  final int artworkId;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final bool unlocked;

  ArtworkScanned({
    required this.id,
    required this.artworkId,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.unlocked,
  });

  factory ArtworkScanned.fromMap(Map<String, dynamic> map) {
    return ArtworkScanned(
      id: map['id'],
      artworkId: map['artwork_id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      imageUrl: map['image_url'],
      unlocked: map['unlocked'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artwork_id': artworkId,
      'title': title,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      'unlocked': unlocked ? 1 : 0,
    };
  }
}