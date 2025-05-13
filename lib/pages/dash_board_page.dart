import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/base/base_view_model.dart';
import '../core/services/firebase_service.dart';

class DashboardController extends BaseViewModel {
  final FirebaseService _firebaseService;
  final RxInt totalUsers = 0.obs;
  final RxInt totalDrivers = 0.obs;
  final RxInt totalTrips = 0.obs;
  final RxDouble totalEarnings = 0.0.obs;

  DashboardController(this._firebaseService);

  @override
  void onInit() {
    super.onInit();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setLoading(true);
      
      // Load users count
      final usersSnapshot = await _firebaseService.getData(_firebaseService.usersRef);
      if (usersSnapshot.value != null) {
        totalUsers.value = (usersSnapshot.value as Map).length;
      }

      // Load drivers count
      final driversSnapshot = await _firebaseService.getData(_firebaseService.driversRef);
      if (driversSnapshot.value != null) {
        totalDrivers.value = (driversSnapshot.value as Map).length;
      }

      // Load trips data
      final tripsSnapshot = await _firebaseService.getData(_firebaseService.tripsRef);
      if (tripsSnapshot.value != null) {
        final trips = tripsSnapshot.value as Map;
        totalTrips.value = trips.length;
        
        // Calculate total earnings
        double earnings = 0;
        trips.forEach((_, tripData) {
          if (tripData is Map && tripData['fare'] != null) {
            earnings += (tripData['fare'] as num).toDouble();
          }
        });
        totalEarnings.value = earnings;
      }
    } catch (e) {
      showError('Failed to load dashboard data: $e');
    } finally {
      setLoading(false);
    }
  }
}

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller._loadDashboardData(),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    'Total Users',
                    controller.totalUsers.toString(),
                    Icons.people,
                    Colors.blue,
                  ),
                  _buildStatCard(
                    'Total Drivers',
                    controller.totalDrivers.toString(),
                    Icons.drive_eta,
                    Colors.green,
                  ),
                  _buildStatCard(
                    'Total Trips',
                    controller.totalTrips.toString(),
                    Icons.map,
                    Colors.orange,
                  ),
                  _buildStatCard(
                    'Total Earnings',
                    '\$${controller.totalEarnings.toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.purple,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
