import 'base_model.dart';
import 'vehicle_details.dart';

class DriverModel extends BaseModel {
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? blockStatus;
  bool? isAvailable;
  bool? isApproved;
  double? rating;
  int? totalTrips;
  double? totalEarnings;
  VehicleDetails? vehicleDetails;

  DriverModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.blockStatus,
    this.isAvailable,
    this.isApproved,
    this.rating,
    this.totalTrips,
    this.totalEarnings,
    this.vehicleDetails,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      blockStatus: json['blockStatus'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      isApproved: json['isApproved'] as bool?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      totalTrips: json['totalTrips'] as int?,
      totalEarnings: json['totalEarnings'] != null 
          ? (json['totalEarnings'] as num).toDouble() 
          : null,
      vehicleDetails: json['vehicleDetails'] != null
          ? VehicleDetails.fromJson(json['vehicleDetails'] as Map<String, dynamic>)
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
      'isAvailable': isAvailable,
      'isApproved': isApproved,
      'rating': rating,
      'totalTrips': totalTrips,
      'totalEarnings': totalEarnings,
      'vehicleDetails': vehicleDetails?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  DriverModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? blockStatus,
    bool? isAvailable,
    bool? isApproved,
    double? rating,
    int? totalTrips,
    double? totalEarnings,
    VehicleDetails? vehicleDetails,
    String? createdAt,
    String? updatedAt,
  }) {
    return DriverModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      blockStatus: blockStatus ?? this.blockStatus,
      isAvailable: isAvailable ?? this.isAvailable,
      isApproved: isApproved ?? this.isApproved,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
