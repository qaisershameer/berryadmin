import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view_model.dart';
import '../../models/driver_model.dart';
import '../../core/repositories/driver_repository.dart';

class DriversController extends BaseViewModel {
  final DriverRepository _repository;
  final RxList<DriverModel> drivers = <DriverModel>[].obs;

  DriversController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _listenToDrivers();
  }

  void _listenToDrivers() {
    _repository.getDrivers().listen(
      (driversList) {
        drivers.value = driversList;
      },
      onError: (error) {
        showError('Failed to load drivers: $error');
      },
    );
  }

  Future<void> toggleDriverApproval(String driverId, bool isApproved) async {
    try {
      setLoading(true);
      await _repository.toggleDriverApproval(driverId, isApproved);
      showSuccess('Driver ${isApproved ? 'approved' : 'rejected'} successfully');
    } catch (e) {
      showError('Failed to ${isApproved ? 'approve' : 'reject'} driver: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> toggleDriverBlock(String driverId, bool isBlocked) async {
    try {
      setLoading(true);
      await _repository.toggleDriverBlock(driverId, isBlocked);
      showSuccess('Driver ${isBlocked ? 'blocked' : 'unblocked'} successfully');
    } catch (e) {
      showError('Failed to ${isBlocked ? 'block' : 'unblock'} driver: $e');
    } finally {
      setLoading(false);
    }
  }
}

class DriversPage extends GetView<DriversController> {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drivers Management'),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.drivers.length,
                itemBuilder: (context, index) {
                  final driver = controller.drivers[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(driver.photo ?? ''),
                        onBackgroundImageError: (_, __) => const Icon(Icons.person),
                      ),
                      title: Text(driver.name ?? 'N/A'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Vehicle: ${driver.vehicleDetails?.model ?? 'N/A'}'),
                          Text('Rating: ${driver.rating?.toStringAsFixed(1) ?? 'N/A'}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              driver.isApproved == true ? Icons.check_circle : Icons.pending,
                              color: driver.isApproved == true ? Colors.green : Colors.orange,
                            ),
                            onPressed: () => controller.toggleDriverApproval(
                              driver.id!,
                              !(driver.isApproved ?? false),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              driver.blockStatus == 'yes' ? Icons.block : Icons.check_circle,
                              color: driver.blockStatus == 'yes' ? Colors.red : Colors.green,
                            ),
                            onPressed: () => controller.toggleDriverBlock(
                              driver.id!,
                              driver.blockStatus != 'yes',
                            ),
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
