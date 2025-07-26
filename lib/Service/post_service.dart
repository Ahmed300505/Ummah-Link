import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:islamicinstapp/Model/Like.dart';
import 'package:islamicinstapp/Model/post_model.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a new post
  Future<Post> createPost({
    required String communityName,
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final postRef = _firestore.collection('posts').doc();
    final post = Post(
      id: postRef.id,
      userId: user.uid,
      userUuid: user.uid, // Or generate a UUID if needed
      communityName: communityName,
      title: title,
      content: content,
      imageUrl: imageUrl,
    );

    await postRef.set(post.toMap());
    return post;
  }

  // Get all posts
  Stream<List<Post>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Post.fromMap(doc.data()))
        .toList());
  }

  // Update a post
  Future<void> updatePost({
    required String postId,
    String? title,
    String? content,
    String? imageUrl,
  }) async {
    await _firestore.collection('posts').doc(postId).update({
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'updatedAt': DateTime.now(),
    });
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Future<void> likePost(String postId, String userId, String userUuid, String userName, String? userProfileImage) async {
    try {
      // Option 1: Using posts/{postId}/likes/{userId} subcollection
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userId)
          .set({
        'userId': userId,
        'userUuid': userUuid,
        'userName': userName,
        'userProfileImage': userProfileImage,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update post likes count
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'likesCount': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId]),
      });

      debugPrint('Like added successfully');
    } catch (e) {
      debugPrint('Error in likePost: $e');
      rethrow;
    }
  }

  // Unlike a post
  Future<void> unlikePost(String postId, String userId) async {
    // Find the like document to delete
    final likeQuery = await _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (likeQuery.docs.isNotEmpty) {
      final likeId = likeQuery.docs.first.id;

      await _firestore.runTransaction((transaction) async {
        // Delete from likes collection
        transaction.delete(_firestore.collection('likes').doc(likeId));

        // Update post likes count and likedBy list
        transaction.update(_firestore.collection('posts').doc(postId), {
          'likesCount': FieldValue.increment(-1),
          'likedBy': FieldValue.arrayRemove([userId]),
        });
      });
    }
  }

  // Get likes for a post
  Stream<List<Like>> getLikesForPost(String postId) {
    return _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Like.fromMap(doc.data()))
        .toList());
  }

  // Check if current user liked a post
  Stream<bool> isPostLikedByUser(String postId, String userId) {
    return _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }
}