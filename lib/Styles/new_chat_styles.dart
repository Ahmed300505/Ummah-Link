// new_chat_styles.dart
import 'package:flutter/material.dart';

class NewChatStyles {
  static const Color primaryColor = Colors.blue;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color secondaryTextColor = Colors.grey;
  static const Color dividerColor = Color(0xFFE0E0E0);

  static TextStyle appBarTitleTextStyle(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle toTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 20 : 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle contactNameTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 16 : 18,
    );
  }

  static TextStyle contactDescriptionTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      fontSize: isSmallScreen ? 14 : 16,
      color: secondaryTextColor,
    );
  }

  static EdgeInsets contactItemPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  }

  static EdgeInsets headerPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20);
  }

  static double avatarRadius(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return isSmallScreen ? 24 : 28;
  }

  static TextStyle avatarTextStyle(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return TextStyle(
      color: Colors.white,
      fontSize: isSmallScreen ? 18 : 20,
    );
  }

  static double arrowIconSize(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    return isSmallScreen ? 18 : 20;
  }
}