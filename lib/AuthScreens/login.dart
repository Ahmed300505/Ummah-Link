import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/login_provider.dart';
import 'package:islamicinstapp/Styles/colors.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/AuthScreens/register.dart';
import 'package:islamicinstapp/screens/home_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isVerySmallScreen = screenSize.height < 600;
    final isNarrowScreen = screenSize.width < 350;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: isVerySmallScreen ? 10 : 20,
              horizontal: isNarrowScreen ? 5 : 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Login Form Container
                Container(
                  width: screenSize.width * (isNarrowScreen ? 0.95 : 0.9),
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: EdgeInsets.symmetric(
                    horizontal: isNarrowScreen ? 5 : 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5DC),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Logo
                      _buildLogo(context, isVerySmallScreen, isNarrowScreen),

                      // Title and Sign Up link
                      _buildHeader(context, isVerySmallScreen, isNarrowScreen),

                      // Form Fields
                      _buildFormFields(context, isVerySmallScreen, isNarrowScreen),

                      // Forget Password
                      _buildForgotPassword(context, isVerySmallScreen, isNarrowScreen),

                      // Login Button
                      _buildLoginButton(context, isVerySmallScreen, isNarrowScreen),

                      // Add some bottom padding for very small screens
                      SizedBox(height: isVerySmallScreen ? 10 : 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isVerySmallScreen, bool isNarrowScreen) {
    final double logoSize = isVerySmallScreen
        ? (isNarrowScreen ? 80 : 90)
        : isNarrowScreen ? 110 : 140;

    return Transform.translate(
      offset: Offset(0, isVerySmallScreen ? -25 : -40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular logo background
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(logoSize / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/elipse.png',
                fit: BoxFit.cover,
              ),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isVerySmallScreen, bool isNarrowScreen) {
    return Padding(
      padding: EdgeInsets.only(
        top: isVerySmallScreen ? 5 : 15,
        bottom: isVerySmallScreen ? 10 : 20,
      ),
      child: Column(
        children: [
          Text(
            'Login',
            style: TextStyles.loginTitleText(context)?.copyWith(
              fontSize: isVerySmallScreen
                  ? (isNarrowScreen ? 22 : 24)
                  : 28,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isNarrowScreen ? 10 : 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Don't have an account? ",
                    style: TextStyles.loginFooterText(context)?.copyWith(
                      fontSize: isVerySmallScreen ? 12 : 14,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyles.loginFooterText(context)?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isVerySmallScreen ? 12 : 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(BuildContext context, bool isVerySmallScreen, bool isNarrowScreen) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrowScreen ? 15 : 20,
      ),
      child: Column(
        children: [
          _buildTextField(
            context: context,
            controller: loginProvider.emailController,
            hintText: 'Email Address',
            icon: Icons.email_outlined,
            isVerySmallScreen: isVerySmallScreen,
            isNarrowScreen: isNarrowScreen,
          ),
          SizedBox(height: isVerySmallScreen ? 8 : 12),
          _buildPasswordField(
            context: context,
            controller: loginProvider.passwordController,
            isVerySmallScreen: isVerySmallScreen,
            isNarrowScreen: isNarrowScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isVerySmallScreen = false,
    bool isNarrowScreen = false,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: isVerySmallScreen ? 14 : 16,
        ),
        prefixIcon: Icon(icon, color: Colors.white, size: isVerySmallScreen ? 20 : 24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isVerySmallScreen ? 12 : 15,
          horizontal: 15,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    bool isVerySmallScreen = false,
    bool isNarrowScreen = false,
  }) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return TextField(
      controller: controller,
      obscureText: loginProvider.obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: isVerySmallScreen ? 14 : 16,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.white,
          size: isVerySmallScreen ? 20 : 24,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            loginProvider.obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white70,
            size: isVerySmallScreen ? 20 : 24,
          ),
          onPressed: () => loginProvider.togglePasswordVisibility(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isVerySmallScreen ? 12 : 15,
          horizontal: 15,
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context, bool isVerySmallScreen, bool isNarrowScreen) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: isNarrowScreen ? 15 : 20,
          top: isVerySmallScreen ? 5 : 10,
          bottom: isVerySmallScreen ? 5 : 0,
        ),
        child: TextButton(
          onPressed: () => _showForgotPasswordDialog(context),
          child: Text(
            'Forgot Password?',
            style: TextStyles.forgotPasswordText(context)?.copyWith(
              fontSize: isVerySmallScreen ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final emailController = TextEditingController();
    final auth = FirebaseAuth.instance;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Enter your email',
            hintText: 'example@email.com',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await auth.sendPasswordResetEmail(
                  email: emailController.text.trim(),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent')),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
  Widget _buildLoginButton(BuildContext context, bool isVerySmallScreen, bool isNarrowScreen) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Padding(
      padding: EdgeInsets.all(isVerySmallScreen ? 12 : 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: isVerySmallScreen ? 12 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          onPressed: loginProvider.isLoading
              ? null
              : () {
            // Validate email format
            if (!loginProvider.emailController.text.contains('@')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid email')),
              );
              return;
            }

            // Validate password length
            if (loginProvider.passwordController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password must be at least 6 characters')),
              );
              return;
            }

            loginProvider.login(context);
          },
          child: loginProvider.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
            'Login',
            style: TextStyles.loginButtonText(context)?.copyWith(
              fontSize: isVerySmallScreen ? 16 : 18,
            ),
          ),
        ),
      ),
    );
  }}