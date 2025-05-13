import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view_model.dart';
import '../../models/trip_model.dart';
import '../../core/services/firebase_service.dart';

class TripsController extends BaseViewModel {
  final FirebaseService _firebaseService;
  final RxList<TripModel> trips = <TripModel>[].obs;

  TripsController(this._firebaseService);

  @override
  void onInit() {
    super.onInit();
    _listenToTrips();
  }

  void _listenToTrips() {
    _firebaseService.getDataStream(_firebaseService.tripsRef).listen(
      (event) {
        if (event.snapshot.value == null) {
          trips.value = [];
          return;
        }
        
        final Map<dynamic, dynamic> data = event.snapshot.value as Map;
        trips.value = data.entries.map((e) => TripModel.fromJson({
          'id': e.key,
          ...Map<String, dynamic>.from(e.value as Map),
        })).toList();
      },
      onError: (error) {
        showError('Failed to load trips: $error');
      },
    );
  }

  Future<void> updateTripStatus(String tripId, String status) async {
    try {
      setLoading(true);
      await _firebaseService.updateData(
        _firebaseService.tripsRef,
        tripId,
        {'status': status},
      );
      showSuccess('Trip status updated successfully');
    } catch (e) {
      showError('Failed to update trip status: $e');
    } finally {
      setLoading(false);
    }
  }
}

class TripsPage extends GetView<TripsController> {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips Management'),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.trips.length,
                itemBuilder: (context, index) {
                  final trip = controller.trips[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text('Trip #${trip.id?.substring(0, 8) ?? 'N/A'}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('From: ${trip.pickupAddress ?? 'N/A'}'),
                          Text('To: ${trip.dropoffAddress ?? 'N/A'}'),
                          Text('Status: ${trip.status ?? 'N/A'}'),
                          Text('Fare: \$${trip.fare?.toStringAsFixed(2) ?? 'N/A'}'),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String status) {
                          if (trip.id != null) {
                            controller.updateTripStatus(trip.id!, status);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'pending',
                            child: Text('Pending'),
                          ),
                          const PopupMenuItem(
                            value: 'in_progress',
                            child: Text('In Progress'),
                          ),
                          const PopupMenuItem(
                            value: 'completed',
                            child: Text('Completed'),
                          ),
                          const PopupMenuItem(
                            value: 'cancelled',
                            child: Text('Cancelled'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
