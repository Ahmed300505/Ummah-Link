// notification_styles.dart
import 'package:flutter/material.dart';

class NotificationStyles {
  static const Color backgroundColor = Color(0xFFFCF5DB);
  static const Color primaryColor = Color(0xFF094B4A);
  static const Color textColor = Colors.black;
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color splashColor = Color(0xFF094B4A);

  static TextStyle appBarTitleTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 18 : (screenWidth < 600 ? 20 : 22),
      fontWeight: FontWeight.bold,
      color: textColor,
    );
  }

  static TextStyle sectionHeaderTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 18 : 20,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
  }

  static TextStyle notificationTitleTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 14 : (screenWidth < 600 ? 15 : 16),
      fontWeight: FontWeight.w600,
      color: textColor,
    );
  }

  static TextStyle notificationSubtitleTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth < 375 ? 12 : 13,
      color: textColor.withOpacity(0.7),
    );
  }

  static EdgeInsets notificationPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: screenWidth < 375 ? 4.0 : 8.0,
      vertical: screenWidth < 375 ? 12.0 : 14.0,
    );
  }

  static EdgeInsets pagePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: screenWidth < 375 ? 12.0 : (screenWidth < 600 ? 16.0 : 20.0),
      vertical: 8.0,
    );
  }

  static double notificationImageSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 375 ? 42 : 48;
  }
}