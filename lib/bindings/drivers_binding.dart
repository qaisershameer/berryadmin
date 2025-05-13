import 'package:get/get.dart';
import '../pages/drivers/drivers_page.dart';
import '../core/repositories/driver_repository.dart';

class DriversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriversController(Get.find<DriverRepository>()));
  }
} 