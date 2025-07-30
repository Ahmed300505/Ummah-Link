import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForYouService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveForYouInterests(List<String> selectedItems) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final data = {
        'uuid': user.uid,
        'userId': user.uid,
        'interests': selectedItems,
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _firestore.collection('Foryou').doc(user.uid).set(data);
    } catch (e) {
      rethrow;
    }
  }
}
