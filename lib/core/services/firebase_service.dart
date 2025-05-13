import 'package:firebase_database/firebase_database.dart';
import '../../utils/q_const.dart';

class FirebaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  DatabaseReference get usersRef => _database.ref().child(QConst.userCollection);
  DatabaseReference get driversRef => _database.ref().child(QConst.driversCollection);
  DatabaseReference get tripsRef => _database.ref().child(QConst.tripRequestsCollection);

  Future<DataSnapshot> getData(DatabaseReference ref) async {
    return await ref.get();
  }

  Future<void> addData(DatabaseReference ref, Map<String, dynamic> data) async {
    final newRef = ref.push();
    await newRef.set({
      ...data,
      'id': newRef.key,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateData(DatabaseReference ref, String id, Map<String, dynamic> data) async {
    await ref.child(id).update(data);
  }

  Future<void> deleteData(DatabaseReference ref, String id) async {
    await ref.child(id).remove();
  }

  Stream<DatabaseEvent> getDataStream(DatabaseReference ref) {
    return ref.onValue;
  }
} 