import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _name = 'User';
  String _username = '@User';
  String _bio = 'Share your favourite quran verse';
  String _profileImageUrl = '';
  String _bannerImageUrl = '';
  bool _isLoading = true;
  String? _errorMessage;

  String get name => _name;
  String get username => _username;
  String get bio => _bio;
  String get profileImage => _profileImageUrl;
  String get bannerImage => _bannerImageUrl;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  EditProfileProvider() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        _errorMessage = 'No user logged in';
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        _name = doc['name'] ?? 'User';
        _username = doc['username'] ?? '@User${user.uid.substring(0, 6)}';
        _bio = doc['bio'] ?? 'Share your favourite quran verse';
        _profileImageUrl = doc['profileImageUrl'] ?? '';
        _bannerImageUrl = doc['bannerImageUrl'] ?? '';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updateBio(String newBio) {
    _bio = newBio;
    notifyListeners();
  }

  Future<void> pickImage({required bool isProfile}) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final user = _auth.currentUser;
      if (user == null) return;

      final path = 'users/${user.uid}/${isProfile ? 'profile' : 'banner'}.jpg';
      final ref = _storage.ref().child(path);
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();

      if (isProfile) {
        _profileImageUrl = url;
      } else {
        _bannerImageUrl = url;
      }

      notifyListeners();
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final User? user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      await _firestore.collection('users').doc(user.uid).set({
        'name': _name,
        'username': _username,
        'bio': _bio,
        'profileImageUrl': _profileImageUrl,
        'bannerImageUrl': _bannerImageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await user.updateDisplayName(_name);

      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      _errorMessage = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
