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

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comment: json['comment'],
      artwork_id: json['artwork_id'],
      visible: json['visible'],
    );
  }
  static List<CommentModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CommentModel.fromJson(json)).toList();
  }
}