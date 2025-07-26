// splash_styles.dart
import 'package:flutter/material.dart';

class SplashStyles {
  static const Color primaryColor = Color(0xFF094B4A);
  static const Color secondaryColor = Color(0xFFDBE5D0);
  static const Color accentColor = Color(0xFFD4AF37);
  static const Color darkColor = Color(0xFF033941);

  static TextStyle appTitleStyle(bool isVerySmallScreen) {
    return TextStyle(
      fontSize: isVerySmallScreen ? 24 : 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle descriptionTextStyle(bool isVerySmallScreen) {
    return TextStyle(
      fontSize: isVerySmallScreen ? 14 : 16,
      color: Colors.white70,
    );
  }

  static TextStyle sliderTitleStyle(bool isNarrowScreen, bool isSmallScreen) {
    return TextStyle(
      fontSize: isNarrowScreen ? 22 : (isSmallScreen ? 26 : 30),
      fontWeight: FontWeight.w700,
      color: const Color(0xFFDBE5D0),
      height: 1.3,
    );
  }

  static TextStyle buttonTextStyle(bool isNarrowScreen) {
    return TextStyle(
      fontSize: isNarrowScreen ? 16 : 18,
      fontWeight: FontWeight.bold,
    );
  }

  static ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: SplashStyles.secondaryColor,
      foregroundColor: SplashStyles.darkColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
    );
  }

  static BoxDecoration logoDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      image: const DecorationImage(
        image: AssetImage('assets/images/elipse.png'),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

// New method for the larger intersecting logo widget
  Widget buildIntersectingLogo() {
    final double logoSize = 180; // Larger size as requested

    return Stack(
      alignment: Alignment.center,
      children: [
        // Main circular logo container with your existing decoration
        Container(
          width: logoSize,
          height: logoSize,
          decoration: logoDecoration().copyWith(
            borderRadius: BorderRadius.circular(logoSize / 2),
          ),
        ),

        // U-shaped image overlay
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(logoSize * 0.3),
            child: Image.asset(
              'assets/images/ulogo.png',
              width: logoSize * 0.8,
              height: logoSize * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  static BoxDecoration animationContainerDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.1),
      border: Border.all(
        color: SplashStyles.accentColor.withOpacity(0.3),
        width: 2,
      ),
    );
  }
}