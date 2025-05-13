abstract class BaseModel {
  String? id;
  String? createdAt;
  String? updatedAt;

  BaseModel({
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson();
} 