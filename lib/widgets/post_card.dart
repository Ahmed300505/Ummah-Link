import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamicinstapp/Model/post_model.dart';
import 'package:islamicinstapp/Provider/home_provider.dart';
import 'package:islamicinstapp/screens/post_detail_page.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLikePressed;
  final VoidCallback onShowLikesPressed;
  final VoidCallback onSavePressed;
  final VoidCallback onCommentPressed;
  final String userId; // Added userId parameter
  final bool isSaved; // Added isSaved parameter

  const PostCard({
    super.key,
    required this.post,
    required this.onLikePressed,
    required this.onShowLikesPressed,
    required this.onSavePressed,
    required this.onCommentPressed,
    required this.userId, // Required in constructor
    required this.isSaved, // Required in constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(postId: post.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Post header with logo and plus icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/images/homelogo1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      post.communityName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF033941),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 32),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Main post image
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                post.imageUrl ?? '',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Post actions (like, share, comment, save)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post.likedBy.contains(userId) ? Icons.favorite : Icons.favorite_border,
                        size: 28,
                        color: post.likedBy.contains(userId) ? Colors.red : const Color(0xFF033941),
                      ),
                      onPressed: () async {
                        onLikePressed();
                        await Future.delayed(const Duration(milliseconds: 300));
                        // No need for mounted check in StatelessWidget
                      },
                    ),
                    GestureDetector(
                      onTap: onShowLikesPressed,
                      child: Text(
                        '${post.likesCount} likes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(
                        Icons.comment_outlined,
                        size: 28,
                        color: Color(0xFF033941),
                      ),
                      onPressed: onCommentPressed,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 28,
                    color: const Color(0xFF033941),
                  ),
                  onPressed: onSavePressed,
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Post text and stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${post.communityName}: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                        TextSpan(
                          text: post.content,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'View all ${post.commentsCount} comments',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}