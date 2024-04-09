class UserUpload {
  final int artworkId;
  final String title;
  final String description;
  final String filePath;

  UserUpload({
    required this.artworkId,
    required this.title,
    required this.description,
    required this.filePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId,
      'title': title,
      'description': description,
      'filePath': filePath,
    };
  }
}
