import 'package:artswindsoressex/Screens/Models/TagModel.dart';

class UserUpload {
  final int artworkId; // The ID of the artwork
  final String title; // The title of the artwork
  final String description; // The description of the artwork
  final String filePath; // The file path of the uploaded image
  final List<TagModel> tags; // The list of tags associated with the artwork

  UserUpload({
    required this.artworkId, // Constructor to initialize the artwork ID
    required this.title, // Constructor to initialize the artwork title
    required this.description, // Constructor to initialize the artwork description
    required this.filePath, // Constructor to initialize the file path of the uploaded image
    required this.tags, // Constructor to initialize the list of tags
  });

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId, // Converting artwork ID to JSON
      'title': title, // Converting artwork title to JSON
      'description': description, // Converting artwork description to JSON
      'filePath': filePath, // Converting file path of uploaded image to JSON
      'tags': tags, // Converting list of tags to JSON
    };
  }
}
