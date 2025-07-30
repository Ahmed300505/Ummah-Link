import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamicinstapp/Service/AuthService.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:islamicinstapp/screens/umrahLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  XFile? _profileImage;
  XFile? _bannerImage;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  XFile? get profileImage => _profileImage;
  XFile? get bannerImage => _bannerImage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> pickImage(bool isProfile) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (isProfile) {
          _profileImage = pickedFile;
        } else {
          _bannerImage = pickedFile;
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<String?> _uploadImage(XFile? image, String path) async {
    if (image == null) return null;

    try {
      debugPrint('Starting image upload: $path');

      final Reference storageRef = FirebaseStorage.instance.ref().child(path);
      final File imageFile = File(image.path);

      debugPrint('Image file exists: ${imageFile.existsSync()}');
      debugPrint('Image size: ${imageFile.lengthSync()} bytes');

      final UploadTask uploadTask = storageRef.putFile(imageFile);

      // Show upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        debugPrint('Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('Image uploaded successfully. URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
  Future<void> register(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final selectedRole = prefs.getString('selectedRole') ?? 'member';
    _isLoading = true;
    notifyListeners();

    try {
      // First register the user
      final authService = AuthService();
      final user = await authService.registerWithEmailAndPassword(
        name: nameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRole,
      );

      if (user == null || user.uid.isEmpty) {
        throw Exception('Failed to register user');
      }

      // Then upload images with the user's UID
      String? profileImageUrl;
      String? bannerImageUrl;

      if (_profileImage != null) {
        profileImageUrl = await _uploadImage(
            _profileImage,
            'users/${user.uid}/profile_images/${DateTime.now().millisecondsSinceEpoch}_profile.jpg'
        );
      }

      if (_bannerImage != null) {
        bannerImageUrl = await _uploadImage(
            _bannerImage,
            'users/${user.uid}/banner_images/${DateTime.now().millisecondsSinceEpoch}_banner.jpg'
        );
      }

      // Update user with image URLs
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profileImageUrl': profileImageUrl,
        'bannerImageUrl': bannerImageUrl,
        'bio': bioController.text.trim(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UmrahLinks()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Error: ${e.toString()}')),
      );
      debugPrint('Registration error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose(); // <--- add this
    super.dispose();
  }
}