import 'package:get/get.dart';
import '../pages/trips/trips_page.dart';
import '../core/services/firebase_service.dart';

class TripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripsController(Get.find<FirebaseService>()));
  }
} 