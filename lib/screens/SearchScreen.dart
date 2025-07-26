import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const _SearchPageContent(),
    );
  }
}

class _SearchPageContent extends StatelessWidget {
  const _SearchPageContent();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    final isMediumScreen = screenWidth >= 375 && screenWidth < 600;

    return Scaffold(
      backgroundColor: AppColors.umrahBackground,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16.0 : isMediumScreen ? 20.0 : 24.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildSearchBar(context, isSmallScreen),
            const SizedBox(height: 24),
            _buildTrendingSection(context),
            const SizedBox(height: 24),
            _buildCommunitiesSection(context, isSmallScreen, isMediumScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.umrahBackground,
          contentPadding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 12.0 : 14.0,
            horizontal: 20.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          hintText: 'Search...',
          prefixIcon: const Icon(
            Icons.search,
            size: 28,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Trending for You',
            style: TextStyles.searchSectionTitleText(context),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: searchProvider.trendingItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item['text'] as String,
                    style: TextStyles.searchTrendingItemText(context),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCommunitiesSection(
      BuildContext context,
      bool isSmallScreen,
      bool isMediumScreen
      ) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Communities Near You',
            style: TextStyles.searchSectionTitleText(context),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: searchProvider.communities.map((community) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Card Header
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                        topLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Logo
                        Container(
                          width: isSmallScreen ? 40 : 48,
                          height: isSmallScreen ? 40 : 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(community['logo']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Title and Description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community['title']!,
                                style: TextStyles.searchCommunityTitleText(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                community['description']!,
                                style: TextStyles.searchCommunityDescriptionText(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Card Body
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community['mainImageTitle']!,
                                style: TextStyles.searchCommunitySubtitleText(context),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  community['mainImage']!,
                                  width: double.infinity,
                                  height: isSmallScreen ? 120 :
                                  (isMediumScreen ? 150 : 180),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 12 : 16),
                        // Map Image Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community['mapTitle']!,
                                style: TextStyles.searchCommunitySubtitleText(context),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  community['mapImage']!,
                                  width: double.infinity,
                                  height: isSmallScreen ? 120 :
                                  (isMediumScreen ? 150 : 180),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}