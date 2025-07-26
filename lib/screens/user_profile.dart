import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/profile_provider.dart';
import 'package:islamicinstapp/screens/SettiingPage.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/screens/edit_profile_page.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: const _UserProfileContent(),
    );
  }
}

class _UserProfileContent extends StatelessWidget {
  const _UserProfileContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileBackground,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profileData = profileProvider.profileData;
          final screenSize = MediaQuery.of(context).size;
          final horizontalPadding = screenSize.width < 350 ? 12.0 : 16.0;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // Cover Photo
                        _buildCoverPhoto(context, profileData['coverPhoto']),

                        // Profile Content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Column(
                            children: [
                              _buildProfileInfo(context, profileData),
                              _buildProfileActions(context),
                              _buildCommunitySection(
                                  context,
                                  'My Communities:',
                                  profileData['communities']
                              ),
                              _buildCommunitySection(
                                  context,
                                  'Awliya:',
                                  profileData['awliya']
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Profile Stats and Image
                    _buildProfileStatsAndImage(context, profileData),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCoverPhoto(BuildContext context, String coverPhoto) {
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight < 600
        ? 180.0
        : screenHeight < 700
        ? 200.0
        : screenHeight < 800
        ? 220.0
        : 240.0;

    final isNetwork = coverPhoto.startsWith('http');

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isNetwork
              ? NetworkImage(coverPhoto)
              : AssetImage(coverPhoto) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, Map<String, dynamic> profileData) {
    return Column(
      children: [
        SizedBox(height: _getProfileImageSize(context) * 0.5),
        Text(
          profileData['name'],
          style: TextStyles.profileNameText(context),
        ),
        SizedBox(height: _getSmallSpacing(context) / 2),
        Text(
          profileData['username'],
          style: TextStyles.profileUsernameText(context),
        ),
        SizedBox(height: _getSmallSpacing(context)),
        Text(
          profileData['bio'],
          style: TextStyles.profileBioText(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _getMediumSpacing(context)),
      ],
    );
  }

  Widget _buildProfileActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Edit Profile Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              },
              child: Container(
                height: _getButtonHeight(context),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.profileButtonBorder,
                      width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyles.profileButtonText(context),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: _getMediumSpacing(context)),

          // Settings Button
          Container(
            width: _getButtonHeight(context),
            height: _getButtonHeight(context),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.profileButtonBorder,
                  width: 1.5
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: AppColors.profileButtonBorder,
                size: TextStyles.profileButtonText(context).fontSize! * 1.2,
              ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunitySection(BuildContext context, String title, List<dynamic> items) {
    return Column(
      children: [
        SizedBox(height: _getLargeSpacing(context)),
        // Section Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.profileSectionTitleText(context),
              ),
            ],
          ),
        ),
        SizedBox(height: _getSmallSpacing(context)),

        // Community List
        SizedBox(
          height: _getCommunityItemHeight(context),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(context)),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map<String, dynamic>;
              return Container(
                width: _getCommunityItemWidth(context),
                margin: EdgeInsets.only(right: _getMediumSpacing(context)),
                child: Column(
                  children: [
                    // Community Avatar
                    Container(
                      width: _getCommunityAvatarSize(context),
                      height: _getCommunityAvatarSize(context),
                      decoration: BoxDecoration(
                        color: AppColors.communityAvatar,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          item['initials'],
                          style: TextStyle(
                            fontSize: _getCommunityAvatarTextSize(context),
                            fontWeight: FontWeight.bold,
                            color: AppColors.profileText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: _getSmallSpacing(context) / 2),
                    Text(
                      item['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.communityNameText(context),
                    ),
                    Text(
                      item['role'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.communityRoleText(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStatsAndImage(BuildContext context, Map<String, dynamic> profileData) {
    return Positioned(
      top: _getCoverPhotoHeight(context) - (_getProfileImageSize(context) * 0.5),
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Followers
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profileData['followers'],
                style: TextStyles.profileStatsText(context),
              ),
              Text(
                'Followers',
                style: TextStyles.profileStatsLabelText(context),
              ),
            ],
          ),

          SizedBox(width: _getMediumSpacing(context) * 1.5),

          // Profile Image
          Container(
            width: _getProfileImageSize(context),
            height: _getProfileImageSize(context),
            decoration: BoxDecoration(
              color: AppColors.profileText,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.profileBackground,
                width: _getProfileImageBorderWidth(context),
              ),
            ),
            child: ClipOval(
              child: (profileData['profileImage'] != null &&
                  profileData['profileImage'].toString().startsWith('http'))
                  ? Image.network(
                profileData['profileImage'],
                fit: BoxFit.cover,
              )
                  : Image.asset(
                profileData['profileImage'],
                fit: BoxFit.cover,
              ),
            ),

          ),

          SizedBox(width: _getMediumSpacing(context) * 1.5),

          // Following
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profileData['following'],
                style: TextStyles.profileStatsText(context),
              ),
              Text(
                'Following',
                style: TextStyles.profileStatsLabelText(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Responsive helper methods
  double _getCoverPhotoHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 180.0 :
    screenHeight < 700 ? 200.0 :
    screenHeight < 800 ? 220.0 : 240.0;
  }

  double _getProfileImageSize(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 100.0 :
    screenHeight < 700 ? 130.0 :
    screenHeight < 800 ? 150.0 : 170.0;
  }

  double _getProfileImageBorderWidth(BuildContext context) {
    return MediaQuery.of(context).size.width < 350 ? 3.0 : 4.0;
  }

  double _getButtonHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 30.0 :
    screenHeight < 700 ? 32.0 :
    screenHeight < 800 ? 35.0 : 38.0;
  }

  double _getCommunityItemHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 120.0 :
    screenHeight < 700 ? 140.0 :
    screenHeight < 800 ? 160.0 : 180.0;
  }

  double _getCommunityItemWidth(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 70.0 :
    screenHeight < 700 ? 80.0 :
    screenHeight < 800 ? 90.0 : 100.0;
  }

  double _getCommunityAvatarSize(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 50.0 :
    screenHeight < 700 ? 70.0 :
    screenHeight < 800 ? 90.0 : 110.0;
  }

  double _getCommunityAvatarTextSize(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 16.0 :
    screenHeight < 700 ? 20.0 :
    screenHeight < 800 ? 24.0 : 28.0;
  }

  double _getHorizontalPadding(BuildContext context) {
    return MediaQuery.of(context).size.width < 350 ? 12.0 : 16.0;
  }

  double _getSmallSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 4.0 :
    screenHeight < 700 ? 6.0 :
    screenHeight < 800 ? 8.0 : 10.0;
  }

  double _getMediumSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 8.0 :
    screenHeight < 700 ? 12.0 :
    screenHeight < 800 ? 16.0 : 20.0;
  }

  double _getLargeSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 20.0 :
    screenHeight < 700 ? 30.0 :
    screenHeight < 800 ? 40.0 : 50.0;
  }
}