import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/auth_selection_provider.dart';
import 'package:islamicinstapp/Styles/colors.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/AuthScreens/login.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:islamicinstapp/screens/umrahLinks.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthSelectionProvider(),
      child: const _AuthSelectionContent(),
    );
  }
}

class _AuthSelectionContent extends StatelessWidget {
  const _AuthSelectionContent();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Screen size classifications
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 320;
    final isSmallScreen = screenHeight < 700;
    final isMediumScreen = screenHeight < 800;
    final isNarrowScreen = screenWidth < 350;
    final isWideScreen = screenWidth > 400;

    // Responsive spacing
    final topPadding = isVerySmallScreen ? 30.0 :
    isSmallScreen ? 50.0 :
    isMediumScreen ? 70.0 : 80.0;

    final titleBottomPadding = isVerySmallScreen ? 40.0 :
    isSmallScreen ? 80.0 :
    isMediumScreen ? 100.0 : 120.0;

    final buttonsBottomPadding = isVerySmallScreen ? 40.0 :
    isSmallScreen ? 80.0 :
    isMediumScreen ? 120.0 : 160.0;

    final bottomButtonPadding = isVerySmallScreen ? 20.0 :
    isSmallScreen ? 30.0 : 40.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrowScreen ? 16.0 :
            isWideScreen ? 32.0 : 24.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),

              // "Join the" text
              Text(
                'Join the',
                style: TextStyles.joinTheText(context),
              ),

              // "Link!" text with responsive positioning
              Padding(
                padding: EdgeInsets.only(
                  left: isVerySmallScreen
                      ? screenWidth * 0.3
                      : isSmallScreen
                      ? screenWidth * 0.35
                      : screenWidth * 0.4,
                ),
                child: Text(
                  'Link!',
                  style: TextStyles.linkText(context),
                ),
              ),
              SizedBox(height: titleBottomPadding),

              // Buttons Container
              Center(
                child: Consumer<AuthSelectionProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      padding: EdgeInsets.all(isVerySmallScreen ? 10.0 : 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Member Button
                          SizedBox(
                            width: isVerySmallScreen ? screenWidth * 0.35 :
                            isSmallScreen ? 130.0 : 140.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: provider.isMemberSelected
                                    ? AppColors.secondary
                                    : AppColors.secondary.withOpacity(0.7),
                                foregroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                    vertical: isVerySmallScreen ? 10.0 : 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: provider.isMemberSelected
                                        ? AppColors.secondary.withOpacity(0.8)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                elevation: 4,
                                shadowColor: AppColors.secondary.withOpacity(0.5),
                              ),
                              onPressed: () {
                                provider.selectMember();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                                );
                              },
                              child: Text(
                                'Member',
                                style: TextStyles.buttonText(context),
                              ),
                            ),
                          ),

                          SizedBox(width: isVerySmallScreen ? 12.0 :
                          isSmallScreen ? 20.0 : 30.0),

                          // Leader Button
                          SizedBox(
                            width: isVerySmallScreen ? screenWidth * 0.35 :
                            isSmallScreen ? 130.0 : 140.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !provider.isMemberSelected
                                    ? AppColors.secondary
                                    : AppColors.secondary.withOpacity(0.7),
                                foregroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                    vertical: isVerySmallScreen ? 10.0 : 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: !provider.isMemberSelected
                                        ? AppColors.secondary.withOpacity(0.8)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                elevation: 4,
                                shadowColor: AppColors.secondary.withOpacity(0.5),
                              ),
                              onPressed: () {
                                provider.selectLeader();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                                );
                              },
                              child: Text(
                                'Leader',
                                style: TextStyles.buttonText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: buttonsBottomPadding),

              // "Already part of it?" text
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: Text(
                    'Already Apart of it?',
                    textAlign: TextAlign.center,
                    style: TextStyles.bottomText(context),
                  ),
                ),
              ),

              const Spacer(),

              // Login button
              Center(
                child: SizedBox(
                  width: isVerySmallScreen ? screenWidth * 0.4 : 150.0,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textLight,
                      side: const BorderSide(color: Colors.black),
                      padding: EdgeInsets.symmetric(
                          vertical: isVerySmallScreen ? 10.0 : 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      // Add your login navigation logic here
                    },
                    child: Text(
                      'LOG IN',
                      style: TextStyles.buttonText(context)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),

              SizedBox(height: isVerySmallScreen ? 8.0 : 16.0),

              // Guest text
              Center(
                child: Text(
                  'Guest',
                  style: TextStyles.guestText(context),
                ),
              ),

              SizedBox(height: bottomButtonPadding),
            ],
          ),
        ),
      ),
    );
  }
}