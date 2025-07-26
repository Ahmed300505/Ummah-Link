import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/messaging_provider.dart';
import 'package:islamicinstapp/Styles/messaging_styles.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/screens/newchat.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MessagingProvider>(
        builder: (context, provider, child) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(context, provider),
              _buildTrendingChannelsSection(context, provider),
              _buildForumList(context, provider),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, MessagingProvider provider) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 0,
      title: Container(
        height: 40,
        decoration: MessagingStyles.searchBarDecoration(context),
        child: const TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: MessagingStyles.secondaryTextColor),
            hintText: 'SEARCH',
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
        _buildNewMessageButton(context, provider),
      ],
    );
  }

  Widget _buildNewMessageButton(BuildContext context, MessagingProvider provider) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.create_new_folder_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewChatScreen()),
            );
          },
        ),
        if (provider.notificationCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: MessagingStyles.notificationBadgeDecoration(context),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                provider.notificationCount.toString(),
                style: MessagingStyles.notificationBadgeTextStyle(context),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  SliverToBoxAdapter _buildTrendingChannelsSection(
      BuildContext context, MessagingProvider provider) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MessagingStyles.sectionPadding(context),
            child: const Text(
              'Trending Channels',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildProfileCard(
                    context: context,
                    channel: provider.trendingChannels[0],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildProfileCard(
                    context: context,
                    channel: provider.trendingChannels[1],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required BuildContext context,
    required Map<String, dynamic> channel,
  }) {
    return Container(
      padding: MessagingStyles.profileCardPadding(context),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: MessagingStyles.avatarRadius(context),
            backgroundColor: MessagingStyles.primaryColor,
            child: Text(
              channel['avatar'],
              style: MessagingStyles.avatarTextStyle(context),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel['name'],
                  style: MessagingStyles.profileCardNameTextStyle(context),
                ),
                Text(
                  channel['description'],
                  style: MessagingStyles.profileCardDescriptionTextStyle(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  channel['followers'],
                  style: MessagingStyles.profileCardFollowersTextStyle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverList _buildForumList(BuildContext context, MessagingProvider provider) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _buildForumItem(
            context: context,
            item: provider.forumItems[index],
          );
        },
        childCount: provider.forumItems.length,
      ),
    );
  }

  Widget _buildForumItem({
    required BuildContext context,
    required Map<String, dynamic> item,
  }) {
    return Column(
      children: [
        Padding(
          padding: MessagingStyles.forumItemPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CircleAvatar(
                      backgroundColor: MessagingStyles.primaryColor,
                      child: Text(
                        item['avatar'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: MessagingStyles.forumItemNameTextStyle(context),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['description'],
                          style: MessagingStyles.forumItemDescriptionTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: MessagingStyles.dividerColor,
        ),
      ],
    );
  }
}