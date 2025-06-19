class CreateCommentModel {
  int userId;
  int postId;
  String comment;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  CreateCommentModel({
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "postId": postId,
      "comment": comment,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "updatedAt": updatedAt?.millisecondsSinceEpoch,
      "deletedAt": deletedAt?.millisecondsSinceEpoch,
    };
  }
}
