import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';

class ContentModel extends ContentEntity {
  ContentModel({
    required super.id,
    required super.content,
    required super.createdAt,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json["id"],
      content: json["content"] ,
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "created_at": createdAt.toIso8601String(),
    };
  }
}