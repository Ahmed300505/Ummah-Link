// Firestore Service (like_service.dart)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> likePost(String postId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final likeRef = _firestore.collection('likes').doc('${postId}_${user.uid}');

    final doc = await likeRef.get();
    if (!doc.exists) {
      await likeRef.set({
        'userId': user.uid,
        'userUuid': user.uid,
        'postId': postId,
        'profileImage': user.photoURL ?? '',
        'name': user.displayName ?? 'Anonymous',
        'likedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> unlikePost(String postId) async {
    final user = _auth.currentUser;
    if (user == null) return;
    final likeRef = _firestore.collection('likes').doc('${postId}_${user.uid}');
    await likeRef.delete();
  }

  Stream<List<Map<String, dynamic>>> getLikes(String postId) {
    return _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<bool> hasUserLiked(String postId) async {
    final user = _auth.currentUser;
    if (user == null) return false;
    final doc = await _firestore.collection('likes').doc('${postId}_${user.uid}').get();
    return doc.exists;
  }
}
