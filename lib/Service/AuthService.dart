// services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamicinstapp/Model/userModel.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel?> registerWithEmailAndPassword({
    required String name,
    required String username,
    required String email,
    required String password,
    String? profileImageUrl,
    String? bannerImageUrl,
    String role = 'user',
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uuid = _uuid.v4();

      UserModel user = UserModel(
        uid: credential.user!.uid,
        uuid: uuid,
        name: name,
        username: username,
        email: email,
        role: role,
        profileImageUrl: profileImageUrl,
        bannerImageUrl: bannerImageUrl,
        bio: '',
        followers: [],
        following: [],
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toMap());

      return user;
    } catch (e) {
      debugPrint('Error during registration: $e');
      if (profileImageUrl != null) {
        try {
          await _storage.refFromURL(profileImageUrl).delete();
        } catch (e) {
          debugPrint('Error deleting profile image: $e');
        }
      }
      if (bannerImageUrl != null) {
        try {
          await _storage.refFromURL(bannerImageUrl).delete();
        } catch (e) {
          debugPrint('Error deleting banner image: $e');
        }
      }
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      DocumentSnapshot doc =
      await _firestore.collection('users').doc(credential.user!.uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      user = _auth.currentUser;
      return user?.emailVerified ?? false;
    }
    return false;
  }
}