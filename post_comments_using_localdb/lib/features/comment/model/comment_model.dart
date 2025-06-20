class CommentModel {
  int id;
  int userId;
  int postId;
  String comment;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  CommentModel copyWith({required comment, required updatedAt}) {
    return CommentModel(
      id: id,
      userId: userId,
      postId: postId,
      comment: comment ?? this.comment,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CommentModel.fromDatabase(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      userId: map['userId'],
      postId: map['postId'],
      comment: map['comment'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
              : null,
      deletedAt:
          map['deletedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'])
              : null,
    );
  }

  Map<String, dynamic> toUpdateDatabase() {
    return {"comment": comment, "updatedAt": updatedAt?.millisecondsSinceEpoch};
  }
}
