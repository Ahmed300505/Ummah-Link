import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/FailureScreen.dart';
import 'package:islamicinstapp/screens/SuccessScreen.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 400;
    final padding = isSmall ? 20.0 : 24.0;
    final fieldHeight = isSmall ? 46.0 : 50.0;

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
          children: [
            const SizedBox(height: 20),
            Image.asset("assets/images/launchingicon.png", height: 150),
            const SizedBox(height: 30),

            _buildTextField("Current Password", fieldHeight, controller: currentPasswordController),
            const SizedBox(height: 14),
            _buildTextField("New Password", fieldHeight, controller: newPasswordController),
            const SizedBox(height: 14),
            _buildTextField("Confirm New Password", fieldHeight, controller: confirmPasswordController),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF033941),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  String newPassword = newPasswordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();

                  if (newPassword == confirmPassword && newPassword.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SuccessScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FailureScreen()),
                    );
                  }
                },
                child: const Text("CHANGE",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildTextField(String hint, double height, {required TextEditingController controller}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
