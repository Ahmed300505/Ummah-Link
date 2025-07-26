import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/new_chat_provider.dart';
import 'package:islamicinstapp/Styles/new_chat_styles.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Consumer<NewChatProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                _buildContactList(context, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'New Chat',
        style: NewChatStyles.appBarTitleTextStyle(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;

    return Padding(
      padding: NewChatStyles.headerPadding(context),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            size: isSmallScreen ? 28 : 32,
            color: NewChatStyles.primaryColor,
          ),
          const SizedBox(width: 15),
          Text(
            'To...',
            style: NewChatStyles.toTextStyle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(BuildContext context, NewChatProvider provider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.contacts.length,
      itemBuilder: (context, index) {
        final contact = provider.contacts[index];
        return _buildContactItem(
          context: context,
          avatar: contact['avatar'],
          name: contact['name'],
          description: contact['description'],
          isGroup: contact['isGroup'] ?? false,
          isOnline: contact['isOnline'] ?? false,
        );
      },
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required String avatar,
    required String name,
    required String description,
    required bool isGroup,
    bool isOnline = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: NewChatStyles.contactItemPadding(context),
          child: Row(
            children: [
              // Avatar with online indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: NewChatStyles.avatarRadius(context),
                    backgroundColor: NewChatStyles.primaryColor,
                    child: Text(
                      avatar,
                      style: NewChatStyles.avatarTextStyle(context),
                    ),
                  ),
                  if (!isGroup && isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 15),
              // Contact info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: NewChatStyles.contactNameTextStyle(context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: NewChatStyles.contactDescriptionTextStyle(context),
                    ),
                  ],
                ),
              ),
              // Forward arrow
              Icon(
                Icons.arrow_forward_ios,
                size: NewChatStyles.arrowIconSize(context),
                color: NewChatStyles.secondaryTextColor,
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: NewChatStyles.dividerColor,
        ),
      ],
    );
  }
}