import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/post_detail_page.dart';
import 'package:islamicinstapp/widgets/app_bar.dart';
import 'package:islamicinstapp/widgets/user_header.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const UserHeaderSection(),
          _buildCommunityDropdown(context),
          const SizedBox(height: 8),
          _buildPostsList(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildCommunityDropdown(BuildContext context) {
    final communities = [
      'All',
      'General Discussion',
      'Quran Study Group',
      'Islamic Questions',
      'Sisters Forum',
      'New Muslims',
      'Islamic Finance',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: AppColors.homeBackground,
              value: 'All',
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.communityDropdown),
              iconSize: 24,
              style: TextStyles.communityDropdownText(context),
              onChanged: (String? newValue) {},
              items: communities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.communityDropdown,
                        child: Icon(Icons.group, size: 14, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context) {
    final staticPosts = [
      StaticPost(
        id: '1',
        communityName: 'Quran Study Group',
        imageUrl: 'assets/images/homepagepost1.png',
        content: 'Today we discussed Surah Al-Fatiha and its meanings. What are your thoughts?',
        likesCount: 24,
        commentsCount: 8,
        likedBy: [],
      ),
      StaticPost(
        id: '2',
        communityName: 'Islamic Questions',
        imageUrl: 'assets/images/homepagepost2.png',
        content: 'Question about prayer times when traveling. How do you adjust?',
        likesCount: 15,
        commentsCount: 12,
        likedBy: [],
      ),
      StaticPost(
        id: '3',
        communityName: 'Sisters Forum',
        imageUrl: 'assets/images/homepagepost3.png',
        content: 'Beautiful hijab styles for summer season. Share your favorites!',
        likesCount: 42,
        commentsCount: 18,
        likedBy: [],
      ),
      StaticPost(
        id: '4',
        communityName: 'New Muslims',
        imageUrl: 'assets/images/homepagepost1.png',
        content: 'My journey to Islam - sharing my story with everyone here.',
        likesCount: 56,
        commentsCount: 23,
        likedBy: [],
      ),
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: staticPosts.length,
        itemBuilder: (context, index) {
          final post = staticPosts[index];
          return StaticPostCard(
            post: post,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(postId: post.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StaticPost {
  final String id;
  final String communityName;
  final String imageUrl;
  final String content;
  final int likesCount;
  final int commentsCount;
  final List<String> likedBy;

  StaticPost({
    required this.id,
    required this.communityName,
    required this.imageUrl,
    required this.content,
    required this.likesCount,
    required this.commentsCount,
    required this.likedBy,
  });
}

class StaticPostCard extends StatelessWidget {
  final StaticPost post;
  final VoidCallback onTap;

  const StaticPostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: Image.asset(
                post.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
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
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 28,
                        color: Color(0xFF033941),
                      ),
                      onPressed: () {},
                    ),
                    GestureDetector(
                      onTap: () {},
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
                      onPressed: () {
                        onTap(); // Navigate to detail page when comment icon is pressed
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                    size: 28,
                    color: Color(0xFF033941),
                  ),
                  onPressed: () {},
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

