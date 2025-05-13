import 'package:get/get.dart';
import '../pages/users/users_page.dart';
import '../core/repositories/user_repository.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController(Get.find<UserRepository>()));
  }
} 