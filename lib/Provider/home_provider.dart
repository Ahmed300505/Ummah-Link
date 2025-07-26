import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamicinstapp/Model/Like.dart';
import 'package:islamicinstapp/Service/post_service.dart';
import 'package:islamicinstapp/Model/post_model.dart';
import 'package:islamicinstapp/screens/likedialogue.dart';

class HomeProvider with ChangeNotifier {
  final PostService _postService = PostService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String selectedCommunity = 'All';
  List<Post> _posts = [];
  bool _isLoading = false;

  final List<String> communities = [
    'All',
    'General Discussion',
    'Quran Study Group',
    'Islamic Questions',
    'Sisters Forum',
    'New Muslims',
    'Islamic Finance',
  ];

  List<Post> get posts {
    if (selectedCommunity == 'All') return _posts;
    return _posts.where((post) => post.communityName == selectedCommunity).toList();
  }

  bool get isLoading => _isLoading;

  void changeCommunity(String value) {
    selectedCommunity = value;
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _postService.getPosts().listen((posts) {
        _posts = posts;
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching posts: $e');
    }
  }

  Future<void> toggleLike(Post post) async {
    final user = _auth.currentUser;
    if (user == null || user.uid.isEmpty) {
      debugPrint('User not authenticated or invalid UID');
      // Consider showing a login prompt
      return;
    }

    try {
      if (post.likedBy.contains(user.uid)) {
        await _postService.unlikePost(post.id, user.uid);
      } else {
        await _postService.likePost(
          post.id,
          user.uid,
          user.uid,
          user.displayName ?? 'Anonymous',
          user.photoURL,
        );
      }
    } catch (e) {
      debugPrint('Like operation failed: $e');
      // Show error to user

    }
  }

  Future<void> showLikesDialog(BuildContext context, String postId) async {
    final likesStream = _postService.getLikesForPost(postId);

    await showDialog(
      context: context,
      builder: (context) => LikesDialog(likesStream: likesStream),
    );
  }}