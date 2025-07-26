import 'package:flutter/material.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class UserAboutScreen extends StatelessWidget {
  const UserAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    final padding = isSmall ? 16.0 : 20.0;
    final avatarSize = isSmall ? 80.0 : 100.0;
    final nameFontSize = isSmall ? 14.0 : 16.0;
    final joinedFontSize = isSmall ? 12.0 : 13.5;
    final tileFontSize = isSmall ? 14.0 : 16.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFDEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFDEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "About",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: Colors.grey.shade400,
              child: Icon(Icons.person, size: avatarSize * 0.5, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              "User238974",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Joined August 2025",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to privacy policy
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Terms of Use",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to terms of use
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:CustomBottomNavBar()
    );
  }
}
