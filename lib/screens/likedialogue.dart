import 'package:flutter/material.dart';
import 'package:islamicinstapp/Model/Like.dart';

class LikesDialog extends StatelessWidget {
  final Stream<List<Like>> likesStream;

  const LikesDialog({super.key, required this.likesStream});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Likes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Like>>(
                stream: likesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No likes yet'));
                  }

                  final likes = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: likes.length,
                    itemBuilder: (context, index) {
                      final like = likes[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundImage: like.userProfileImage != null
                              ? NetworkImage(like.userProfileImage!)
                              : null,
                          child: like.userProfileImage == null
                              ? Text(like.userName.isNotEmpty
                              ? like.userName[0].toUpperCase()
                              : '?')
                              : null,
                        ),
                        title: Text(
                          like.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Liked ${_timeAgo(like.createdAt)}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onTap: () {
                          // Navigate to user profile
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (_) => UserProfileScreen(userId: like.userId)
                          // ));
                        },
                      );
                    },
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}