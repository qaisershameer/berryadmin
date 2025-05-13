import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/trip_model.dart';

class TripController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final RxList<TripModel> trips = <TripModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('trips');
      final DataSnapshot snapshot = await ref.get();

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map;
        trips.value = values.entries.map((entry) {
          return TripModel.fromJson({
            'id': entry.key,
            ...Map<String, dynamic>.from(entry.value as Map)
          });
        }).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trips: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTrip(TripModel trip) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('trips').push();
      final String tripId = ref.key!;
      
      await ref.set({
        ...trip.toJson(),
        'id': tripId,
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'pending',
      });

      await fetchTrips();
      Get.snackbar('Success', 'Trip added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add trip: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTrip(TripModel trip) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('trips/\${trip.id}');
      await ref.update(trip.toJson());
      await fetchTrips();
      Get.snackbar('Success', 'Trip updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update trip: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTrip(String tripId) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('trips/\$tripId');
      await ref.remove();
      await fetchTrips();
      Get.snackbar('Success', 'Trip deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete trip: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTripStatus(String tripId, String status) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('trips/\$tripId');
      await ref.update({'status': status});
      await fetchTrips();
      Get.snackbar('Success', 'Trip status updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update trip status: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
