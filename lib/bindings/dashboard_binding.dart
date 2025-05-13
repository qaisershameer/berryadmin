import 'package:get/get.dart';
import '../pages/dash_board_page.dart';
import '../core/services/firebase_service.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(Get.find<FirebaseService>()));
  }
} 