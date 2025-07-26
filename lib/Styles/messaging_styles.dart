// messaging_styles.dart
import 'package:flutter/material.dart';

class MessagingStyles {
  static const Color backgroundColor = Color(0xFFFEFDEB);
  static const Color primaryColor = Colors.blue;
  static const Color textColor = Colors.black;
  static const Color secondaryTextColor = Colors.grey;
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color searchBorderColor = Colors.black;
  static const Color notificationBadgeColor = Colors.red;

  static TextStyle sectionTitleTextStyle(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle profileCardNameTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 12 : 14,
    );
  }

  static TextStyle profileCardDescriptionTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 10 : 12,
      color: secondaryTextColor,
    );
  }

  static TextStyle profileCardFollowersTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 10 : 12,
      color: primaryColor,
    );
  }

  static TextStyle forumItemNameTextStyle(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  static TextStyle forumItemDescriptionTextStyle(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    return const EdgeInsets.all(16.0);
  }

  static EdgeInsets forumItemPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  }

  static EdgeInsets profileCardPadding(BuildContext context) {
    return const EdgeInsets.all(12);
  }

  static double avatarRadius(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return isSmallScreen ? 20 : 24;
  }

  static TextStyle avatarTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.white,
      fontSize: isSmallScreen ? 16 : 18,
    );
  }

  static BoxDecoration searchBarDecoration(BuildContext context) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: searchBorderColor),
      borderRadius: BorderRadius.circular(20),
    );
  }

  static BoxDecoration notificationBadgeDecoration(BuildContext context) {
    return BoxDecoration(
      color: notificationBadgeColor,
      borderRadius: BorderRadius.circular(10),
    );
  }

  static TextStyle notificationBadgeTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 10,
    );
  }
}