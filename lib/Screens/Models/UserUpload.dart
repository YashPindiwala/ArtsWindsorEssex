import 'package:artswindsoressex/Screens/Models/TagModel.dart';

class UserUpload {
  final int artworkId;
  final String title;
  final String description;
  final String filePath;
  final List<TagModel> tags;

  UserUpload({
    required this.artworkId,
    required this.title,
    required this.description,
    required this.filePath,
    required this.tags
  });

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId,
      'title': title,
      'description': description,
      'filePath': filePath,
      'tags' : tags,
    };
  }
}
