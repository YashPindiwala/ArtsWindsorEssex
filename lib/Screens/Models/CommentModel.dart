class CommentModel {
  final String comment; // The comment text
  final bool visible; // Flag indicating whether the comment is visible
  final int artwork_id; // The ID of the artwork associated with the comment

  CommentModel({
    required this.comment,
    required this.artwork_id,
    required this.visible,
  });

  Map<String, dynamic> toJson() {
    // Method to convert the comment model to JSON format
    return {
      'comment': comment,
      'visible': visible,
      'artwork_id': artwork_id,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    // Factory method to create a comment model from JSON data
    return CommentModel(
      comment: json['comment'], // Parsing comment text from JSON
      artwork_id: json['artwork_id'], // Parsing artwork ID from JSON
      visible: json['visible'], // Parsing visibility flag from JSON
    );
  }

  static List<CommentModel> listFromJson(List<dynamic> jsonList) {
    // Method to create a list of comment models from a JSON list
    return jsonList.map((json) => CommentModel.fromJson(json)).toList();
  }
}
