class VehicleDetails {
  String? make;
  String? model;
  String? year;
  String? color;
  String? plateNumber;
  String? registrationNumber;

  VehicleDetails({
    this.make,
    this.model,
    this.year,
    this.color,
    this.plateNumber,
    this.registrationNumber,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: json['year'] as String?,
      color: json['color'] as String?,
      plateNumber: json['plateNumber'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'plateNumber': plateNumber,
      'registrationNumber': registrationNumber,
    };
  }
} 