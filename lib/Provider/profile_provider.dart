// profile_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> _profileData = {
    'name': 'Loading...',
    'username': 'Loading...',
    'email': 'Loading...',
    'bio': 'Share your favourite quran verse',
    'followers': '2000k',
    'following': '36',
    'coverPhoto': 'assets/images/profileimage.png',
    'profileImage': 'assets/images/profilelogo.png',
    'communities': [
      {
        'name': 'Brother Ahmed',
        'role': 'Imam',
        'initials': 'BA'
      },
      {
        'name': 'Sister Fatima',
        'role': 'Organizer',
        'initials': 'SF'
      },
      // ... keep other static community data
    ],
    'awliya': [
      {
        'name': 'Sheikh Abdullah',
        'role': 'Scholar',
        'initials': 'SA'
      },
      // ... keep other static awliya data
    ],
  };

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, dynamic> get profileData => _profileData;

  ProfileProvider() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          final data = doc.data() ?? {};

          _profileData = {
            ..._profileData,
            'name': data['name'] ?? 'User',
            'username': data['username'] ?? '@User${user.uid.substring(0, 6)}',
            'email': data['email'] ?? user.email ?? 'No email',
            'bio': data['bio'] ?? '',
            'followers': (data['followers'] as List?)?.length.toString() ?? '0',
            'following': (data['following'] as List?)?.length.toString() ?? '0',
            'profileImage': data['profileImageUrl'] ?? 'assets/images/profilelogo.png',
            'coverPhoto': data['bannerImageUrl'] ?? 'assets/images/profileimage.png',
          };
        }
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      _profileData = {
        ..._profileData,
        'name': 'Error loading',
        'username': '@error',
        'email': 'error@domain.com',
        'bio': 'Failed to load bio.',
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> updateProfile(Map<String, dynamic> newData) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        // Update Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'name': newData['name'] ?? _profileData['name'],
          'username': newData['username'] ?? _profileData['username'],
        });

        // Update local state
        _profileData = {
          ..._profileData,
          'name': newData['name'] ?? _profileData['name'],
          'username': newData['username'] ?? _profileData['username'],
          'bio': newData['bio'] ?? _profileData['bio'],
        };

        notifyListeners();
      }
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}