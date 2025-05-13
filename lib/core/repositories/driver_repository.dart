import '../services/firebase_service.dart';
import '../../models/driver_model.dart';

class DriverRepository {
  final FirebaseService _firebaseService;

  DriverRepository(this._firebaseService);

  Stream<List<DriverModel>> getDrivers() {
    return _firebaseService.getDataStream(_firebaseService.driversRef).map((event) {
      if (event.snapshot.value == null) return [];
      
      final Map<dynamic, dynamic> data = event.snapshot.value as Map;
      return data.entries.map((e) => DriverModel.fromJson({
        'id': e.key,
        ...Map<String, dynamic>.from(e.value as Map),
      })).toList();
    });
  }

  Future<void> addDriver(DriverModel driver) async {
    await _firebaseService.addData(_firebaseService.driversRef, {
      ...driver.toJson(),
      'isAvailable': true,
      'isApproved': false,
      'rating': 0.0,
      'totalTrips': 0,
    });
  }

  Future<void> updateDriver(DriverModel driver) async {
    if (driver.id == null) throw Exception('Driver ID cannot be null');
    await _firebaseService.updateData(_firebaseService.driversRef, driver.id!, driver.toJson());
  }

  Future<void> deleteDriver(String driverId) async {
    await _firebaseService.deleteData(_firebaseService.driversRef, driverId);
  }

  Future<void> toggleDriverBlock(String driverId, bool isBlocked) async {
    await _firebaseService.updateData(
      _firebaseService.driversRef,
      driverId,
      {'blockStatus': isBlocked ? 'yes' : 'no'},
    );
  }

  Future<void> toggleDriverApproval(String driverId, bool isApproved) async {
    await _firebaseService.updateData(
      _firebaseService.driversRef,
      driverId,
      {'isApproved': isApproved},
    );
  }

  Future<void> updateDriverRating(String driverId, double rating) async {
    await _firebaseService.updateData(
      _firebaseService.driversRef,
      driverId,
      {'rating': rating},
    );
  }
} 