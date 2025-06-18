class PostModel {
  int id;
  int userId;
  String title;
  String description;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  PostModel copyWith({
    required String title,
    required String description,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id,
      userId: userId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PostModel.fromDatabase(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
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
    return {
      'title': title,
      'description': description,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toDatabaseDelete() {
    return {'deletedAt': DateTime.now().millisecondsSinceEpoch};
  }
}
