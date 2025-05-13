import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('users');
      final DataSnapshot snapshot = await ref.get();

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values = snapshot.value as Map;
        users.value = values.entries.map((entry) {
          return UserModel.fromJson({
            'id': entry.key,
            ...Map<String, dynamic>.from(entry.value as Map)
          });
        }).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('users').push();
      final String userId = ref.key!;
      
      await ref.set({
        ...user.toJson(),
        'id': userId,
        'createdAt': DateTime.now().toIso8601String(),
      });

      await fetchUsers();
      Get.snackbar('Success', 'User added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add user: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('users/\${user.id}');
      await ref.update(user.toJson());
      await fetchUsers();
      Get.snackbar('Success', 'User updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;
      final DatabaseReference ref = _database.ref().child('users/\$userId');
      await ref.remove();
      await fetchUsers();
      Get.snackbar('Success', 'User deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete user: \${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
