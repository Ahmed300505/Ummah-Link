import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islamicinstapp/screens/SearchScreen.dart';
import 'package:islamicinstapp/screens/calender.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:islamicinstapp/screens/Forum.dart';
import 'package:islamicinstapp/screens/user_profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.08;
    final height = size.height * 0.11;
    final iconSize = size.width * 0.08;

    return Container(
      height: height.clamp(70, 110),
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        color: const Color(0xFF033941),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavBarIcon(icon: FontAwesomeIcons.houseChimney, iconSize: iconSize
          ,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          _NavBarIcon(icon: FontAwesomeIcons.magnifyingGlass, iconSize: iconSize,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          _NavBarIcon(icon: FontAwesomeIcons.calendar, iconSize: iconSize
            ,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CalendarScreen()),
              );
            },
          ),
          _NavBarIcon(icon: FontAwesomeIcons.comment, iconSize: iconSize
            ,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ForumScreen()),
              );
            },
          ),
          _NavBarIcon(
            icon: FontAwesomeIcons.user,
            iconSize: iconSize,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback? onTap;

  const _NavBarIcon({
    required this.icon,
    required this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: iconSize.clamp(30, 50),
        color: const Color(0xFFFEFDEB),
      ),
    );
  }
}
