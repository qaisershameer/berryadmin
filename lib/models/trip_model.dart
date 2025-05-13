import 'base_model.dart';

class TripModel extends BaseModel {
  String? userId;
  String? driverId;
  String? pickupAddress;
  String? dropoffAddress;
  double? pickupLat;
  double? pickupLng;
  double? dropoffLat;
  double? dropoffLng;
  String? status;
  double? distance;
  double? duration;
  double? fare;
  String? paymentMethod;
  bool? isPaid;
  double? rating;
  String? feedback;

  TripModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    this.userId,
    this.driverId,
    this.pickupAddress,
    this.dropoffAddress,
    this.pickupLat,
    this.pickupLng,
    this.dropoffLat,
    this.dropoffLng,
    this.status,
    this.distance,
    this.duration,
    this.fare,
    this.paymentMethod,
    this.isPaid,
    this.rating,
    this.feedback,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      driverId: json['driverId'] as String?,
      pickupAddress: json['pickupAddress'] as String?,
      dropoffAddress: json['dropoffAddress'] as String?,
      pickupLat: json['pickupLat'] != null ? (json['pickupLat'] as num).toDouble() : null,
      pickupLng: json['pickupLng'] != null ? (json['pickupLng'] as num).toDouble() : null,
      dropoffLat: json['dropoffLat'] != null ? (json['dropoffLat'] as num).toDouble() : null,
      dropoffLng: json['dropoffLng'] != null ? (json['dropoffLng'] as num).toDouble() : null,
      status: json['status'] as String?,
      distance: json['distance'] != null ? (json['distance'] as num).toDouble() : null,
      duration: json['duration'] != null ? (json['duration'] as num).toDouble() : null,
      fare: json['fare'] != null ? (json['fare'] as num).toDouble() : null,
      paymentMethod: json['paymentMethod'] as String?,
      isPaid: json['isPaid'] as bool?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      feedback: json['feedback'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'driverId': driverId,
      'pickupAddress': pickupAddress,
      'dropoffAddress': dropoffAddress,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'dropoffLat': dropoffLat,
      'dropoffLng': dropoffLng,
      'status': status,
      'distance': distance,
      'duration': duration,
      'fare': fare,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'rating': rating,
      'feedback': feedback,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  TripModel copyWith({
    String? id,
    String? userId,
    String? driverId,
    String? pickupAddress,
    String? dropoffAddress,
    double? pickupLat,
    double? pickupLng,
    double? dropoffLat,
    double? dropoffLng,
    String? status,
    double? distance,
    double? duration,
    double? fare,
    String? paymentMethod,
    bool? isPaid,
    double? rating,
    String? feedback,
    String? createdAt,
    String? updatedAt,
  }) {
    return TripModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropoffAddress: dropoffAddress ?? this.dropoffAddress,
      pickupLat: pickupLat ?? this.pickupLat,
      pickupLng: pickupLng ?? this.pickupLng,
      dropoffLat: dropoffLat ?? this.dropoffLat,
      dropoffLng: dropoffLng ?? this.dropoffLng,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      fare: fare ?? this.fare,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
