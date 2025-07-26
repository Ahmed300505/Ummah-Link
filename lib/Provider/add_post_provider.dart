import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamicinstapp/Service/AuthService.dart';
import 'package:islamicinstapp/Service/post_service.dart';
import 'package:islamicinstapp/Model/post_model.dart';

class AddPostProvider with ChangeNotifier {
  final PostService _postService = PostService();
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();

  String? _selectedCommunity;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  XFile? _imageFile;
  String? _imageUrl;
  bool _isLoading = false;
  bool _isUploading = false;

  // Community list with images
  final List<Map<String, dynamic>> communities = [
    {
      'name': 'General Discussion',
      'image': 'assets/images/islamicevent.jpg',
    },
    {
      'name': 'Quran Study Group',
      'image': 'assets/images/islamicevent2.jpg',
    },
    {
      'name': 'Islamic Questions',
      'image': 'assets/images/postimage1.jpg',
    },
    {
      'name': 'Sisters Forum',
      'image': 'assets/images/postimage2.jpg',
    },
    {
      'name': 'New Muslims',
      'image': 'assets/images/postimage3.jpg',
    },
    {
      'name': 'Islamic Finance',
      'image': 'assets/images/profile_1.jpg',
    }
  ];

  // Getters
  String? get selectedCommunity => _selectedCommunity;
  TextEditingController get titleController => _titleController;
  TextEditingController get contentController => _contentController;
  XFile? get imageFile => _imageFile;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  // Select community
  void selectCommunity(String? community) {
    _selectedCommunity = community;
    notifyListeners();
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _imageFile = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Upload image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    _isUploading = true;
    notifyListeners();

    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageRef.putFile(File(_imageFile!.path));
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      _imageUrl = downloadUrl;
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  // Submit post
  Future<void> submitPost(BuildContext context) async {
    if (_selectedCommunity == null ||
        _titleController.text.isEmpty ||
        _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Upload image if selected
      if (_imageFile != null) {
        await _uploadImage();
      }

      // Get current user
      final user = await _authService.getCurrentUser();
      if (user == null) throw Exception('User not authenticated');

      // Create post
      await _postService.createPost(
        communityName: _selectedCommunity!,
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageUrl,
      );

      // Clear form
      _titleController.clear();
      _contentController.clear();
      _selectedCommunity = null;
      _imageFile = null;
      _imageUrl = null;

      // Close screen with success
      if (context.mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating post: ${e.toString()}')),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}