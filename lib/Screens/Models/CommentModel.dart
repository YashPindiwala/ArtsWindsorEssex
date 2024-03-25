class CommentModel {
  final String comment;
  final bool visible;
  final int artwork_id;

  CommentModel({
        required this.comment,
        required this.artwork_id,
        required this.visible,
      });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'visible': visible,
      'artwork_id': artwork_id,
    };
  }
}