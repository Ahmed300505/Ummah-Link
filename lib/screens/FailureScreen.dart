import 'package:flutter/material.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isSmall = width < 400;
    final padding = isSmall ? 16.0 : 24.0;
    final contentPadding = isSmall ? 24.0 : 32.0;
    final fontSizeTitle = isSmall ? 24.0 : 26.0;
    final fontSizeSubtitle = isSmall ? 13.0 : 14.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFDEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFDEB),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 412,
              height: 660,
              padding: EdgeInsets.symmetric(vertical: contentPadding),
              decoration: BoxDecoration(
                color: const Color(0xFFFDE7E7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/wrong.png", height: 250),
                  const SizedBox(height: 24),
                  Text(
                    "oops!",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "something went wrong, try\nresetting again",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSizeSubtitle),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "try again",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
