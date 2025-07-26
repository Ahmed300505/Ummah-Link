// calendar_styles.dart
import 'package:flutter/material.dart';

class CalendarStyles {
  static const Color backgroundColor = Color(0xFFFCF5DB);
  static const Color primaryColor = Color(0xFF094B4A);
  static const Color whiteColor = Colors.white;
  static const Color white70Color = Colors.white70;

  static TextStyle sectionTitleTextStyle(BuildContext context) {
    return TextStyle(
      color: primaryColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
  }

  static InputDecoration searchInputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width < 375 ? 12.0 : 14.0,
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
      prefixIcon: const Icon(Icons.search, size: 28, color: primaryColor),
    );
  }

  static TextStyle eventsHeaderTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle viewMoreTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w500,
    );
  }

  static BoxDecoration eventsContainerDecoration(BuildContext context) {
    return const BoxDecoration(
      color: Color(0xFF094B4A),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    );
  }

  static BoxDecoration eventCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    );
  }

  static BoxDecoration dateBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white, width: 1.5),
    );
  }

  static TextStyle dateTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventTitleTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle eventTimeTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white70,
      fontSize: 14,
    );
  }
}