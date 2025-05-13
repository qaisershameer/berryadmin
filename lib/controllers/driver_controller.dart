import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/driver_model.dart';

class DriverController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final RxList<DriverModel> drivers = <DriverModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('drivers');
      final DataSnapshot snapshot = await ref.get();

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map;
        drivers.value = values.entries.map((entry) {
          return DriverModel.fromJson({
            'id': entry.key,
            ...Map<String, dynamic>.from(entry.value as Map)
          });
        }).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch drivers: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDriver(DriverModel driver) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('drivers').push();
      final String driverId = ref.key!;
      
      await ref.set({
        ...driver.toJson(),
        'id': driverId,
        'createdAt': DateTime.now().toIso8601String(),
        'isAvailable': true,
        'isApproved': false,
        'rating': 0.0,
        'totalTrips': 0,
      });

      await fetchDrivers();
      Get.snackbar('Success', 'Driver added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add driver: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDriver(DriverModel driver) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('drivers/\${driver.id}');
      await ref.update(driver.toJson());
      await fetchDrivers();
      Get.snackbar('Success', 'Driver updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update driver: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDriver(String driverId) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('drivers/\$driverId');
      await ref.remove();
      await fetchDrivers();
      Get.snackbar('Success', 'Driver deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete driver: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleDriverApproval(String driverId, bool isApproved) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('drivers/\$driverId');
      await ref.update({'isApproved': isApproved});
      await fetchDrivers();
      Get.snackbar('Success', 'Driver approval status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update driver approval: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
