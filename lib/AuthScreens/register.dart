import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/Provider/register_provider.dart';
import 'package:islamicinstapp/Styles/colors.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:islamicinstapp/AuthScreens/login.dart';
import 'package:islamicinstapp/screens/home_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: const _RegisterScreenContent(),
    );
  }
}

class _RegisterScreenContent extends StatelessWidget {
  const _RegisterScreenContent();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; 
    final isExtraSmallScreen = screenSize.height < 600; // Small phones
    final isSmallScreen = screenSize.height < 700; // Medium phones
    final isMediumScreen = screenSize.height < 800; // Large phones
    final isLargeScreen = screenSize.height >= 800; // Tablets
    final isNarrowScreen = screenSize.width < 350;
    final isWideScreen = screenSize.width > 400;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: isExtraSmallScreen ? 10 :
              isSmallScreen ? 15 :
              isMediumScreen ? 20 : 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Register Form Container
                Container(
                  width: isWideScreen ? screenSize.width * 0.85 : screenSize.width * 0.9,
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: EdgeInsets.symmetric(
                    horizontal: isNarrowScreen ? 12 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5DC),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Logo
                      _buildLogo(context, isExtraSmallScreen, isSmallScreen),

                      // Title and Sign In link
                      _buildHeader(context, isExtraSmallScreen, isSmallScreen, isNarrowScreen),

                      // Form Fields
                      _buildFormFields(context, isExtraSmallScreen, isSmallScreen, isMediumScreen, isNarrowScreen),

                      // Register Button
                      _buildRegisterButton(context, isExtraSmallScreen, isSmallScreen, isMediumScreen),
                    ],
                  ),
                ),

                // Terms and Privacy text
                _buildTermsAndPrivacy(context, isExtraSmallScreen, isSmallScreen, isNarrowScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isExtraSmallScreen, bool isSmallScreen) {
    final double logoSize = isExtraSmallScreen ? 90 :
    isSmallScreen ? 110 :
    140;

    return Transform.translate(
      offset: Offset(0, isExtraSmallScreen ? -25 : -40),
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

  Widget _buildHeader(BuildContext context, bool isExtraSmallScreen, bool isSmallScreen, bool isNarrowScreen) {
    return Padding(
      padding: EdgeInsets.only(
        top: isExtraSmallScreen ? 0 :
        isSmallScreen ? 10 : 15,
        bottom: isExtraSmallScreen ? 8 :
        isSmallScreen ? 12 : 20,
      ),
      child: Column(
        children: [
          Text(
            'Create Account',
            style: TextStyles.registerTitleText(context).copyWith(
              fontSize: isExtraSmallScreen ? 22 :
              isSmallScreen ? 24 : 26,
            ),
          ),
          SizedBox(height: isExtraSmallScreen ? 5 : 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyles.registerFooterText(context).copyWith(
                  fontSize: isExtraSmallScreen ? 12 : 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyles.registerFooterText(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isExtraSmallScreen ? 12 : 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(
      BuildContext context,
      bool isExtraSmallScreen,
      bool isSmallScreen,
      bool isMediumScreen,
      bool isNarrowScreen,
      ) {
    final registerProvider = Provider.of<RegisterProvider>(context, listen: false);

    // Calculate responsive gaps
    final double fieldGap = isExtraSmallScreen ? 8 :
    isSmallScreen ? 10 :
    isMediumScreen ? 12 : 14;
    final double sectionGap = isExtraSmallScreen ? 12 :
    isSmallScreen ? 16 :
    isMediumScreen ? 20 : 24;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrowScreen ? 12 :
        isSmallScreen ? 16 :
        20,
      ),
      child: Column(
        children: [
          _buildTextField(
            context: context,
            controller: registerProvider.nameController,
            hintText: 'Name',
            icon: Icons.person,
            isExtraSmallScreen: isExtraSmallScreen,
          ),
          SizedBox(height: fieldGap),
          _buildTextField(
            context: context,
            controller: registerProvider.usernameController,
            hintText: 'Username',
            icon: Icons.person_outline,
            isExtraSmallScreen: isExtraSmallScreen,
          ),
          SizedBox(height: fieldGap),
          _buildTextField(
            context: context,
            controller: registerProvider.emailController,
            hintText: 'Email Address',
            icon: Icons.email_outlined,
            isExtraSmallScreen: isExtraSmallScreen,
          ),
          SizedBox(height: fieldGap),
          _buildTextField(
            context: context,
            controller: registerProvider.bioController,
            hintText: 'Bio (optional)',
            icon: Icons.info_outline,
            isExtraSmallScreen: isExtraSmallScreen,
          ),
          SizedBox(height: sectionGap),
          _buildPasswordField(
            context: context,
            controller: registerProvider.passwordController,
            isExtraSmallScreen: isExtraSmallScreen,
            isPassword: true,
          ),
          SizedBox(height: fieldGap),
          _buildConfirmPasswordField(
            context: context,
            controller: registerProvider.confirmPasswordController,
            isExtraSmallScreen: isExtraSmallScreen,
          ),
          SizedBox(height: sectionGap),
          _buildImagePickerField(
            context: context,
            label: 'Profile Image',
            isProfile: true,
            isExtraSmallScreen: isExtraSmallScreen,
            isSmallScreen: isSmallScreen,
          ),
          SizedBox(height: fieldGap),
          _buildImagePickerField(
            context: context,
            label: 'Banner Image',
            isProfile: false,
            isExtraSmallScreen: isExtraSmallScreen,
            isSmallScreen: isSmallScreen,
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
    bool isExtraSmallScreen = false,
  }) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;

    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: isNarrowScreen ? 18 :
          isExtraSmallScreen ? 20 : 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isExtraSmallScreen ? 12 : 15,
          horizontal: 15,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    bool isExtraSmallScreen = false,
    bool isPassword = false,
  }) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;

    return TextField(
      controller: controller,
      obscureText: registerProvider.obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.white,
          size: isNarrowScreen ? 18 :
          isExtraSmallScreen ? 20 : 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            registerProvider.obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white70,
            size: isNarrowScreen ? 18 :
            isExtraSmallScreen ? 20 : 22,
          ),
          onPressed: () => registerProvider.togglePasswordVisibility(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isExtraSmallScreen ? 12 : 15,
          horizontal: 15,
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    bool isExtraSmallScreen = false,
  }) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    final isNarrowScreen = MediaQuery.of(context).size.width < 350;

    return TextField(
      controller: controller,
      obscureText: registerProvider.obscureConfirmPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        hintText: 'Confirm Password',
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.white,
          size: isNarrowScreen ? 18 :
          isExtraSmallScreen ? 20 : 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            registerProvider.obscureConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white70,
            size: isNarrowScreen ? 18 :
            isExtraSmallScreen ? 20 : 22,
          ),
          onPressed: () => registerProvider.toggleConfirmPasswordVisibility(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isExtraSmallScreen ? 12 : 15,
          horizontal: 15,
        ),
      ),
    );
  }

  Widget _buildImagePickerField({
    required BuildContext context,
    required String label,
    required bool isProfile,
    bool isExtraSmallScreen = false,
    bool isSmallScreen = false,
  }) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    final image = isProfile ? registerProvider.profileImage : registerProvider.bannerImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: isExtraSmallScreen ? 14 : 16,
          ),
        ),
        SizedBox(height: isExtraSmallScreen ? 6 : 8),
        GestureDetector(
          onTap: () => registerProvider.pickImage(isProfile),
          child: Container(
            height: isExtraSmallScreen ? 100 :
            isSmallScreen ? 120 : 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white70, width: 1),
            ),
            child: image == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isProfile ? Icons.person : Icons.image,
                  color: Colors.white70,
                  size: isExtraSmallScreen ? 30 :
                  isSmallScreen ? 35 : 40,
                ),
                SizedBox(height: isExtraSmallScreen ? 4 : 8),
                Text(
                  'Tap to select ${isProfile ? 'profile' : 'banner'} image',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isExtraSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(
      BuildContext context,
      bool isExtraSmallScreen,
      bool isSmallScreen,
      bool isMediumScreen,
      ) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Padding(
      padding: EdgeInsets.all(
        isExtraSmallScreen ? 10 :
        isSmallScreen ? 15 :
        isMediumScreen ? 18 : 20,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: isExtraSmallScreen ? 12 :
              isSmallScreen ? 14 :
              isMediumScreen ? 16 : 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          onPressed: registerProvider.isLoading
              ? null
              : () {
            // Validate fields before registration
            if (registerProvider.nameController.text.isEmpty ||
                registerProvider.usernameController.text.isEmpty ||
                registerProvider.emailController.text.isEmpty ||
                registerProvider.passwordController.text.isEmpty ||
                registerProvider.confirmPasswordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
              );
              return;
            }

            if (registerProvider.passwordController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password must be at least 6 characters')),
              );
              return;
            }

            registerProvider.register(context);
          },
          child: registerProvider.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
            'Register',
            style: TextStyles.registerButtonText(context).copyWith(
              fontSize: isExtraSmallScreen ? 16 : 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy(
      BuildContext context,
      bool isExtraSmallScreen,
      bool isSmallScreen,
      bool isNarrowScreen,
      ) {
    return Padding(
      padding: EdgeInsets.only(
        top: isExtraSmallScreen ? 12 :
        isSmallScreen ? 16 : 20,
        left: 20,
        right: 20,
        bottom: isExtraSmallScreen ? 10 : 15,
      ),
      child: Column(
        children: [
          Text(
            'By Creating an account you agree to our',
            style: TextStyles.termsText(context).copyWith(
              fontSize: isExtraSmallScreen ? 12 : 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isExtraSmallScreen ? 3 : 4),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Terms Of Service',
                  style: TextStyles.termsText(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isExtraSmallScreen ? 12 : 14,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'and',
                style: TextStyles.termsText(context).copyWith(
                  fontSize: isExtraSmallScreen ? 12 : 14,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Privacy Policy',
                  style: TextStyles.termsText(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isExtraSmallScreen ? 12 : 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}