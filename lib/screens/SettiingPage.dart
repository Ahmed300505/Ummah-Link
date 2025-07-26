import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/SavedScreen.dart';
import 'package:islamicinstapp/screens/SecurityPrivacyScreen.dart';
import 'package:islamicinstapp/screens/UserAbout.dart';
import 'package:islamicinstapp/screens/UserHomePage.dart';
import 'package:islamicinstapp/screens/UserNotificationPage.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showAccountSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFEFDEB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Switch account",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.grey),
                title: const Text("User238974"),
                trailing: const Icon(Icons.check, color: Color(0xFF033941)),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE6E6E6),
                  child: Icon(Icons.add, color: Color(0xFF033941)),
                ),
                title: const Text("Add account"),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        final isSmall = width < 400;
        final padding = isSmall ? 16.0 : 20.0;
        final fontSize = isSmall ? 15.0 : 17.0;
        final iconSize = isSmall ? 20.0 : 22.0;

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
              "Settings",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  children: [
                    _buildTile(
                      icon: Icons.person_outline,
                      title: "Profile",
                      fontSize: fontSize,
                      iconSize: iconSize,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserHomePageScreen())),
                    ),
                    _buildTile(
                      icon: Icons.bookmark_border,
                      title: "Saved",
                      fontSize: fontSize,
                      iconSize: iconSize,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedPage())),
                    ),
                    _buildTile(
                      icon: Icons.notifications_none,
                      title: "Notifications",
                      fontSize: fontSize,
                      iconSize: iconSize,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserNotificationPage())),
                    ),
                    _buildTile(
                      icon: Icons.lock_outline,
                      title: "Privacy/Security",
                      fontSize: fontSize,
                      iconSize: iconSize,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityPrivacyScreen())),
                    ),
                    _buildTile(
                      icon: Icons.info_outline,
                      title: "About",
                      fontSize: fontSize,
                      iconSize: iconSize,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserAboutScreen())),

                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, thickness: 1),
                    const SizedBox(height: 250),
                    ListTile(
                      title: const Text("Login"),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedPage())),
                    ),
                    ListTile(
                      tileColor: const Color(0xFFEDEDD9),
                      title: const Text("Switch account"),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 14,
                        child: Icon(Icons.person, size: 16, color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () => _showAccountSwitcher(context),
                    ),
                    ListTile(
                      title: const Text("Log out"),
                      onTap: () {
                        // handle logout logic
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          bottomNavigationBar:CustomBottomNavBar()
        );
      },
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required double fontSize,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, size: iconSize, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: onTap,
    );
  }
}
