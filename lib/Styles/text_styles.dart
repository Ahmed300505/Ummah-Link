// text_styles.dart
import 'package:flutter/material.dart';
import 'package:islamicinstapp/Styles/colors.dart';

class TextStyles {
  static TextStyle joinTheText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isVerySmallScreen = screenHeight < 600;
    final isSmallScreen = screenHeight < 700;
    final isMediumScreen = screenHeight < 800;

    return TextStyle(
      fontSize: isVerySmallScreen ? 36.0 :
      isSmallScreen ? 44.0 :
      isMediumScreen ? 52.0 : 60.0,
      fontWeight: FontWeight.w300,
      color: AppColors.textLight,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.5,
      height: 0.9,
    );
  }

  static TextStyle linkText(BuildContext context) {
    return const TextStyle(
      fontSize: 70,
      fontWeight: FontWeight.bold,
      color: AppColors.textLight,
      height: 0.9,
      letterSpacing: 2.0,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isVerySmallScreen = screenHeight < 600;
    final isSmallScreen = screenHeight < 700;

    return TextStyle(
      fontSize: isVerySmallScreen ? 14.0 :
      isSmallScreen ? 16.0 : 18.0,
      color: AppColors.accent,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bottomText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isVerySmallScreen = screenHeight < 600;
    final isSmallScreen = screenHeight < 700;

    return TextStyle(
      color: AppColors.textLight70,
      fontSize: isVerySmallScreen ? 13.0 :
      isSmallScreen ? 15.0 : 17.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle guestText(BuildContext context) {
    final style = bottomText(context);
    return style.copyWith(
      fontSize: style.fontSize! - 1.0,
      decoration: TextDecoration.underline,
    );
  }
  static TextStyle loginTitleText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    return TextStyle(
      fontSize: isNarrowScreen ? 24 : 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }

  static TextStyle loginButtonText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    return TextStyle(
      fontSize: isNarrowScreen ? 16 : 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle loginFooterText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    return TextStyle(
      color: Colors.black,
      fontSize: isNarrowScreen ? 12 : 14,
    );
  }

  static TextStyle forgotPasswordText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    return TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: isNarrowScreen ? 12 : 14,
    );
  }
  // Add these to text_styles.dart
  static TextStyle registerTitleText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return TextStyle(
      fontSize: isNarrowScreen ? 22 : isSmallScreen ? 26 : 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }

  static TextStyle registerButtonText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    return TextStyle(
      fontSize: isNarrowScreen ? 16 : 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle registerFooterText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return TextStyle(
      color: Colors.black,
      fontSize: isNarrowScreen ? 12 : isSmallScreen ? 13 : 14,
    );
  }

  static TextStyle termsText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return TextStyle(
      color: Colors.white,
      fontSize: isNarrowScreen ? 11 : isSmallScreen ? 12 : 14,
    );
  }
  static TextStyle communityDropdownText(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.communityDropdown,
      fontWeight: FontWeight.w600,
    );
  }
  // Add these to text_styles.dart
  static TextStyle profileNameText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight < 600 ? 14.0 :
    screenHeight < 700 ? 15.0 :
    screenHeight < 800 ? 16.0 : 17.0;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.profileText,
    );
  }

  static TextStyle profileUsernameText(BuildContext context) {
    final style = profileNameText(context);
    return style.copyWith(
      fontSize: style.fontSize! - 1.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle profileBioText(BuildContext context) {
    final style = profileNameText(context);
    return style.copyWith(
      fontSize: style.fontSize! - 3.0,
    );
  }

  static TextStyle profileStatsText(BuildContext context) {
    final style = profileNameText(context);
    return style.copyWith(
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle profileStatsLabelText(BuildContext context) {
    final style = profileUsernameText(context);
    return style.copyWith(
      fontWeight: FontWeight.w900,
      color: Colors.grey,
    );
  }

  static TextStyle profileSectionTitleText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight < 600 ? 14.0 :
    screenHeight < 700 ? 16.0 :
    screenHeight < 800 ? 18.0 : 20.0;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.profileText,
    );
  }

  static TextStyle profileButtonText(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight < 600 ? 12.0 :
    screenHeight < 700 ? 13.0 :
    screenHeight < 800 ? 14.0 : 15.0;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.profileButtonBorder,
    );
  }

  static TextStyle communityNameText(BuildContext context) {
    final style = profileButtonText(context);
    return style.copyWith(
      fontSize: style.fontSize! * 0.8,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle communityRoleText(BuildContext context) {
    final style = profileButtonText(context);
    return style.copyWith(
      fontSize: style.fontSize! * 0.7,
      color: Colors.grey,
    );
  }
  // Add these to text_styles.dart
  static TextStyle umrahTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 20.0 :
      screenWidth < 600 ? 22.0 : 24.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle umrahDescriptionText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 12.0 :
      screenWidth < 600 ? 13.0 : 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.umrahText,
    );
  }

  static TextStyle umrahButtonText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 13.0 :
      screenWidth < 600 ? 14.0 : 15.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle umrahContinueButtonText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 16.0 :
      screenWidth < 600 ? 17.0 : 18.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle umrahSkipButtonText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 14.0 :
      screenWidth < 600 ? 15.0 : 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.umrahText,
    );
  }

  static TextStyle umrahAppBarTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 18.0 :
      screenWidth < 600 ? 20.0 : 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
  // Add these to text_styles.dart
  static TextStyle searchSectionTitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle searchTrendingItemText(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle searchCommunityTitleText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 16 : 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle searchCommunityDescriptionText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 13 : 14,
      color: Colors.white.withOpacity(0.9),
    );
  }

  static TextStyle searchCommunitySubtitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  static TextStyle searchSectionTitleTextResponsive(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
  // Add these to text_styles.dart
  static TextStyle postDetailTitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF033941),
    );
  }
  static TextStyle postDetailEmailText(BuildContext context) {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    );
  }
  static TextStyle postDetailStatValueText(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w900,
      color: Color(0xFF033941),
    );
  }

  static TextStyle postDetailStatLabelText(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w900,
      color: Colors.grey,
    );
  }

  static TextStyle postDetailSectionTitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF033941),
    );
  }

  static TextStyle postDetailSectionContentText(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      color: Color(0xFF033941),
    );
  }

  static TextStyle postDetailLeaderNameText(BuildContext context) {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF033941),
    );
  }
  // Add these to text_styles.dart
  static TextStyle notificationTitleText(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 375;
    final isMediumScreen = MediaQuery.of(context).size.width >= 375 &&
        MediaQuery.of(context).size.width < 600;

    return TextStyle(
      fontSize: isNarrowScreen ? 18 : (isMediumScreen ? 20 : 22),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle notificationSectionHeaderText(bool isSmallScreen) {
    return TextStyle(
      fontSize: isSmallScreen ? 18 : 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle notificationItemTitleText(bool isSmallScreen, bool isMediumScreen) {
    return TextStyle(
      fontSize: isSmallScreen ? 14 : (isMediumScreen ? 15 : 16),
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle notificationItemSubtitleText(bool isSmallScreen) {
    return TextStyle(
      fontSize: isSmallScreen ? 12 : 13,
      color: Colors.black.withOpacity(0.7),
    );
  }
// Add these to text_styles.dart
  static TextStyle forumTitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle forumItemNameText(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  static TextStyle forumItemTitleText(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  static TextStyle forumItemDescriptionText(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      color: Colors.grey,
    );
  }

  static TextStyle forumBadgeText(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
  }

  static TextStyle forumActionText(BuildContext context) {
    return const TextStyle(
      fontSize: 12,
    );
  }
  // Add these to text_styles.dart
  static TextStyle editProfileTitleText(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF033941),
    );
  }

  static TextStyle editProfileLabelText(BuildContext context) {
    return const TextStyle(
      color: Color(0xFF033941),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle editProfileButtonText(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
  // Add these to text_styles.dart
  static TextStyle addPostAppBarButtonText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 14 : 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle addPostLabelText(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle addPostDropdownText(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 14,
    );
  }

  static TextStyle addPostHintText(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      color: Colors.grey,
    );
  }
  // Add these to text_styles.dart
  static TextStyle eventDetailTitleText(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventDetailInfoText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.black,
      fontSize: isSmallScreen ? 12 : 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle eventDetailTimeText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.black,
      fontSize: isSmallScreen ? 14 : 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventDetailSectionTitleText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.black,
      fontSize: isSmallScreen ? 18 : 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventDetailDescriptionText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontSize: isSmallScreen ? 14 : 16,
      height: 1.5,
    );
  }

  static TextStyle eventDetailAttendeesText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.black,
      fontSize: isSmallScreen ? 16 : 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventDetailConnectButtonText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 11 : 12,
      color: Colors.white,
    );
  }
}
