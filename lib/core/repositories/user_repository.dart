import '../services/firebase_service.dart';
import '../../models/user_model.dart';

class UserRepository {
  final FirebaseService _firebaseService;

  UserRepository(this._firebaseService);

  Stream<List<UserModel>> getUsers() {
    return _firebaseService.getDataStream(_firebaseService.usersRef).map((event) {
      if (event.snapshot.value == null) return [];
      
      final Map<dynamic, dynamic> data = event.snapshot.value as Map;
      return data.entries.map((e) => UserModel.fromJson({
        'id': e.key,
        ...Map<String, dynamic>.from(e.value as Map),
      })).toList();
    });
  }

  Future<void> addUser(UserModel user) async {
    await _firebaseService.addData(_firebaseService.usersRef, user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    if (user.id == null) throw Exception('User ID cannot be null');
    await _firebaseService.updateData(_firebaseService.usersRef, user.id!, user.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _firebaseService.deleteData(_firebaseService.usersRef, userId);
  }

  Future<void> toggleUserBlock(String userId, bool isBlocked) async {
    await _firebaseService.updateData(
      _firebaseService.usersRef,
      userId,
      {'blockStatus': isBlocked ? 'yes' : 'no'},
    );
  }
} 