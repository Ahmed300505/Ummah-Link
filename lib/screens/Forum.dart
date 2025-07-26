import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/forum_provider.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/screens/AddPostScreen.dart';
import 'package:islamicinstapp/screens/Messaging.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForumProvider(),
      child: const _ForumScreenContent(),
    );
  }
}

class _ForumScreenContent extends StatelessWidget {
  const _ForumScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildTitleSection(context),
          _buildForumList(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        backgroundColor: AppColors.communityDropdown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context);

    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 0,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.forumBackground,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            hintText: 'Search forums...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                forumProvider.clearMessages();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagingScreen()),
                );
              },
            ),
            if (forumProvider.messageCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    forumProvider.messageCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildTitleSection(BuildContext context) {
    return  SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Forums',
          style: TextStyles.forumTitleText(context),
        ),
      ),
    );
  }

  SliverList _buildForumList(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final forumProvider = Provider.of<ForumProvider>(context);
          final item = forumProvider.forumItems[index];
          return _buildForumItem(
            context: context,
            avatar: item['avatar'] as String,
            name: item['name'] as String,
            title: item['title'] as String,
            description: item['description'] as String,
            badges: item['badges'] as List<String>,
            likes: item['likes'] as int,
            comments: item['comments'] as int,
          );
        },
        childCount: Provider.of<ForumProvider>(context).forumItems.length,
      ),
    );
  }

  Widget _buildForumItem({
    required BuildContext context,
    required String avatar,
    required String name,
    required String title,
    required String description,
    required List<String> badges,
    required int likes,
    required int comments,
  }) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar, Name and Title Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.communityDropdown,
                    child: Text(
                      avatar,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles.forumItemNameText(context),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyles.forumItemTitleText(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Description
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Text(
                  description,
                  style: TextStyles.forumItemDescriptionText(context),
                ),
              ),

              const SizedBox(height: 10),

              // Badges
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: badges.map((badge) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getBadgeColor(badge),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        badge,
                        style: TextStyles.forumBadgeText(context),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 10),

              // Like and Comment
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      likes.toString(),
                      style: TextStyles.forumActionText(context),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      comments.toString(),
                      style: TextStyles.forumActionText(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge) {
      case 'QURAN':
        return AppColors.forumBadgeQuran;
      case 'COURSE':
        return AppColors.forumBadgeCourse;
      case 'REVERT':
        return AppColors.forumBadgeRevert;
      case 'TRAVEL':
        return AppColors.forumBadgeTravel;
      case 'SISTERS':
        return AppColors.forumBadgeSisters;
      case 'MASJID':
        return AppColors.forumBadgeMasjid;
      case 'FINANCE':
        return AppColors.forumBadgeFinance;
      case 'BUSINESS':
        return AppColors.forumBadgeBusiness;
      default:
        return Colors.grey;
    }
  }
}