import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/base/base_view_model.dart';
import '../../models/user_model.dart';
import '../../core/repositories/user_repository.dart';

class UsersController extends BaseViewModel {
  final UserRepository _repository;
  final RxList<UserModel> users = <UserModel>[].obs;

  UsersController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _listenToUsers();
  }

  void _listenToUsers() {
    _repository.getUsers().listen(
      (usersList) {
        users.value = usersList;
      },
      onError: (error) {
        showError('Failed to load users: $error');
      },
    );
  }

  Future<void> toggleUserBlock(String userId, bool isBlocked) async {
    try {
      setLoading(true);
      await _repository.toggleUserBlock(userId, isBlocked);
      showSuccess('User ${isBlocked ? 'blocked' : 'unblocked'} successfully');
    } catch (e) {
      showError('Failed to ${isBlocked ? 'block' : 'unblock'} user: $e');
    } finally {
      setLoading(false);
    }
  }
}

class UsersPage extends GetView<UsersController> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Management'),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photo ?? ''),
                      onBackgroundImageError: (_, __) => const Icon(Icons.person),
                    ),
                    title: Text(user.name ?? 'N/A'),
                    subtitle: Text(user.email ?? 'N/A'),
                    trailing: IconButton(
                      icon: Icon(
                        user.blockStatus == 'yes' ? Icons.block : Icons.check_circle,
                        color: user.blockStatus == 'yes' ? Colors.red : Colors.green,
                      ),
                      onPressed: () => controller.toggleUserBlock(
                        user.id!,
                        user.blockStatus != 'yes',
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
