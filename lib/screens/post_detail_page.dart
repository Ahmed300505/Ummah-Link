import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/post_detail_provider.dart';
import 'package:islamicinstapp/screens/PersonMessageScreen.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostDetailProvider(),
      child: Scaffold(
        backgroundColor: AppColors.homeBackground,
        bottomNavigationBar: const CustomBottomNavBar(),
        body: const _PostDetailContent(),
      ),
    );
  }
}

class _PostDetailContent extends StatelessWidget {
  const _PostDetailContent();

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostDetailProvider>(context);
    final community = postProvider.communityData;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final coverPhotoHeight = screenHeight * 0.35;
    final logoSize = screenWidth * 0.4;
    final logoTopPosition = coverPhotoHeight - (logoSize / 2);
    final buttonHeight = screenHeight * 0.06;
    final statValueFontSize = screenWidth * 0.045;
    final statLabelFontSize = screenWidth * 0.03;
    final titleFontSize = screenWidth * 0.06;
    final emailFontSize = screenWidth * 0.035;
    final buttonFontSize = screenWidth * 0.035;
    final tabBarHeight = screenHeight * 0.06;

    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // COVER PHOTO
                Container(
                  height: coverPhotoHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/postdetail1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // SPACE FOR LOGO TO OVERLAP
                SizedBox(height: logoSize / 3),

                // STATS + NAME + TABS
                Column(
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(height: logoSize * 0.3),

                    // NAME
                    Text(
                      community['name'] as String,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.communityDropdown,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      'ahmed@gmail.com',
                      style: TextStyle(
                        fontSize: emailFontSize,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // FOLLOW button
                          Expanded(
                            child: Container(
                              height: buttonHeight,
                              margin: EdgeInsets.only(right: screenWidth * 0.02),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D5D5B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'FOLLOW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: buttonFontSize,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // MESSAGE button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PersonMessageScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: buttonHeight,
                                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7F2DE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'MESSAGE',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: buttonFontSize,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                          // Bell Icon Button
                          Container(
                            height: buttonHeight,
                            width: buttonHeight,
                            margin: EdgeInsets.only(left: screenWidth * 0.02),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F2DE),
                              border: Border.all(color: Colors.black54, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.notifications_none,
                              size: buttonHeight * 0.5,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // TAB BAR
                    Container(
                      height: tabBarHeight,
                      color: AppColors.homeBackground,
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppColors.communityDropdown,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: AppColors.communityDropdown,
                        tabs: [
                          Tab(
                            child: Text(
                              'Posts',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Programs',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'About',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // TAB CONTENT
                    SizedBox(
                      height: screenHeight * 0.6,
                      child: TabBarView(
                        children: [
                          _buildPostsTab(community['posts'] as List<String>, screenWidth),
                          _buildProgramsTab(community['programs'] as List<String>, screenWidth),
                          _buildAboutTab(context, community, screenWidth, screenHeight),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // LOGO AND STATS
// LOGO AND STATS (Updated for spacing & alignment)
            Positioned(
              top: logoTopPosition,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Followers (left)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '2000k',
                            style: TextStyle(
                              fontSize: statValueFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.communityDropdown,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: statLabelFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: screenWidth * 0.05),

                      // Profile Logo
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: AppColors.communityDropdown,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.homeBackground,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            community['image'] as String,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.05),

                      // Following (right)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            community['following'] as String,
                            style: TextStyle(
                              fontSize: statValueFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.communityDropdown,
                            ),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              fontSize: statLabelFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsTab(List<String> images, double screenWidth) {
    return GridView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: screenWidth * 0.02,
        mainAxisSpacing: screenWidth * 0.02,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildProgramsTab(List<String> images, double screenWidth) {
    return GridView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenWidth * 0.03,
        mainAxisSpacing: screenWidth * 0.03,
        childAspectRatio: 1.5,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildAboutTab(BuildContext context, Map<String, dynamic> community, double screenWidth, double screenHeight) {
    final sectionTitleFontSize = screenWidth * 0.045;
    final sectionContentFontSize = screenWidth * 0.038;
    final leaderNameFontSize = screenWidth * 0.035;

    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Us Section
          _buildSection(
            context: context,
            title: 'About Us',
            content: Text(
              community['description']!,
              style: TextStyle(
                fontSize: sectionContentFontSize,
                color: Colors.grey[700],
              ),
            ),
            screenWidth: screenWidth,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Website Section
          _buildSection(
            context: context,
            title: 'Website',
            content: GestureDetector(
              onTap: () {
                // Handle website tap
              },
              child: Text(
                community['website']!,
                style: TextStyle(
                  fontSize: sectionContentFontSize,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            screenWidth: screenWidth,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Directions Section
          _buildSection(
            context: context,
            title: 'Directions',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  community['address']!,
                  style: TextStyle(
                    fontSize: sectionContentFontSize,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.map,
                      size: screenWidth * 0.15,
                      color: AppColors.communityDropdown,
                    ),
                  ),
                ),
              ],
            ),
            screenWidth: screenWidth,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Leaders Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leaders',
                  style: TextStyle(
                    fontSize: sectionTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.communityDropdown,
                  ),
                ),
                Text(
                  'View More',
                  style: TextStyle(
                    fontSize: sectionContentFontSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.communityDropdown,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

          SizedBox(
            height: screenHeight * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: community['leaders'].length,
              itemBuilder: (context, index) {
                final leader = community['leaders'][index];
                return Container(
                  width: screenWidth * 0.25,
                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.communityAvatar,
                          borderRadius: BorderRadius.circular(screenWidth * 0.1),
                        ),
                        child: Center(
                          child: Text(
                            leader['name'].toString().split(' ').map((e) => e[0]).join(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF033941),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        leader['name']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: leaderNameFontSize,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.1),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required Widget content,
    required double screenWidth,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: AppColors.communityDropdown.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.communityDropdown,
            ),
          ),
          SizedBox(height: screenWidth * 0.03),
          content,
        ],
      ),
    );
  }
}