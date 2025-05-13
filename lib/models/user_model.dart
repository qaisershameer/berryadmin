import 'base_model.dart';

class UserModel extends BaseModel {
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? blockStatus;
  double? totalPayments;

  UserModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.blockStatus,
    this.totalPayments,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      blockStatus: json['blockStatus'] as String?,
      totalPayments: json['totalPayments'] != null 
          ? (json['totalPayments'] as num).toDouble() 
          : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'blockStatus': blockStatus,
      'totalPayments': totalPayments,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? blockStatus,
    double? totalPayments,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      blockStatus: blockStatus ?? this.blockStatus,
      totalPayments: totalPayments ?? this.totalPayments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
