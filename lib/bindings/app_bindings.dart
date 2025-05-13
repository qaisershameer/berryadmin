import 'package:get/get.dart';
import '../core/services/firebase_service.dart';
import '../core/repositories/user_repository.dart';
import '../core/repositories/driver_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(FirebaseService(), permanent: true);

    // Repositories
    Get.put(UserRepository(Get.find<FirebaseService>()), permanent: true);
    Get.put(DriverRepository(Get.find<FirebaseService>()), permanent: true);
  }
} 