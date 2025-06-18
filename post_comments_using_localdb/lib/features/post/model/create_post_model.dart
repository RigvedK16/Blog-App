class CreatePostModel {
  int userId;
  String title;
  String description;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  CreatePostModel({
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "title": title,
      "description": description,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "updatedAt": updatedAt?.millisecondsSinceEpoch,
      "deletedAt": deletedAt?.millisecondsSinceEpoch,
    };
  }
}
