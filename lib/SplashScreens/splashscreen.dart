import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/splash_provider.dart';
import 'package:islamicinstapp/Styles/splash_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/SplashScreens/linksPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  final List<Map<String, String>> sliderItems = [
    {
      'title': 'Learn about Islam and connect with the community',
      'animation': 'assets/images/lotie.json',
      'image': 'assets/images/splashscreen1.png',
    },
    {
      'title': 'Never miss your prayers with our accurate prayer times',
      'animation': 'assets/images/lotie.json',
      'image': 'assets/images/splash2.png',
    },
    {
      'title': 'Access authentic Quran and Hadith collections',
      'animation': 'assets/images/lotie.json',
      'image': 'assets/images/splash3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _startAutoNavigation();
  }

  void _startAutoNavigation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final splashProvider = Provider.of<SplashProvider>(context, listen: false);

      if (!splashProvider.showSlider) {
        if (!splashProvider.showDescription) {
          _animationController.forward();
          splashProvider.setShowDescription(true);
        } else {
          splashProvider.setShowSlider(true);
          _timer?.cancel();
          _startSliderAutoNavigation();
        }
      }
    });
  }

  void _startSliderAutoNavigation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final splashProvider = Provider.of<SplashProvider>(context, listen: false);

      if (splashProvider.currentPage < sliderItems.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthSelectionPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isVerySmallScreen = screenSize.height < 600;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 350;
    final splashProvider = Provider.of<SplashProvider>(context);

    return Scaffold(
      backgroundColor: SplashStyles.primaryColor,
      body: SafeArea(
        child: splashProvider.showSlider
            ? _buildSliderScreen(
          screenSize: screenSize,
          isSmallScreen: isSmallScreen,
          isVerySmallScreen: isVerySmallScreen,
          isNarrowScreen: isNarrowScreen,
        )
            : _buildSplashScreen(
          isSmallScreen: isSmallScreen,
          isVerySmallScreen: isVerySmallScreen,
          isNarrowScreen: isNarrowScreen,
        ),
      ),
    );
  }

  Widget _buildSplashScreen({
    required bool isSmallScreen,
    required bool isVerySmallScreen,
    required bool isNarrowScreen,
  }) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    final double logoSize = isVerySmallScreen
        ? (isNarrowScreen ? 120 : 140)
        : isSmallScreen
        ? 160
        : 180;

    return GestureDetector(
      onTap: () {
        _timer?.cancel();
        if (!splashProvider.showDescription) {
          _animationController.forward();
          splashProvider.setShowDescription(true);
          _timer = Timer(const Duration(seconds: 3), () {
            splashProvider.setShowSlider(true);
            _startSliderAutoNavigation();
          });
        } else {
          splashProvider.setShowSlider(true);
          _startSliderAutoNavigation();
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'app-logo',
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Main circular logo container
                  Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(logoSize / 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/elipse.png'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                  ),
                  // U-shaped overlay image
                  Positioned(
                    child: Image.asset(
                      'assets/images/ulogo.png',
                      width: logoSize * 0.8,
                      height: logoSize * 0.5,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isVerySmallScreen ? 15 : 20),
            Text(
              'UMMAH LINK',
              style: SplashStyles.appTitleStyle(isVerySmallScreen),
            ),
            if (splashProvider.showDescription)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isVerySmallScreen ? 20 : 30,
                    left: isNarrowScreen ? 20 : 40,
                    right: isNarrowScreen ? 20 : 40,
                  ),
                  child: Text(
                    'A complete app for Muslims to learn about Islam, prayer times, Quran and more',
                    textAlign: TextAlign.center,
                    style: SplashStyles.descriptionTextStyle(isVerySmallScreen),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderScreen({
    required Size screenSize,
    required bool isSmallScreen,
    required bool isVerySmallScreen,
    required bool isNarrowScreen,
  }) {
    final splashProvider = Provider.of<SplashProvider>(context);

    return PageView.builder(
      controller: _pageController,
      itemCount: sliderItems.length,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) => splashProvider.setCurrentPage(index),
      itemBuilder: (context, index) {
        return Container(
          height: screenSize.height,
          padding: EdgeInsets.symmetric(
            horizontal: isNarrowScreen ? 20 : 30,
            vertical: isVerySmallScreen ? 20 : 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isVerySmallScreen ? 10 : 20),
                  Text(
                    sliderItems[index]['title']!,
                    style: SplashStyles.sliderTitleStyle(
                        isNarrowScreen, isSmallScreen),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isVerySmallScreen ? 20 : 30),
                  Center(
                    child: Container(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(sliderItems[index]['image']!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sliderItems.length,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: isNarrowScreen ? 6 : 8),
                        width: splashProvider.currentPage == index
                            ? (isNarrowScreen ? 16 : 20)
                            : (isNarrowScreen ? 8 : 10),
                        height: isNarrowScreen ? 8 : 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: splashProvider.currentPage == index
                              ? SplashStyles.darkColor
                              : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isVerySmallScreen ? 20 : 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: SplashStyles.getButtonStyle(),
                      onPressed: () {
                        _timer?.cancel();
                        if (splashProvider.currentPage <
                            sliderItems.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          _startSliderAutoNavigation();
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AuthSelectionPage()),
                          );
                        }
                      },
                      child: Text(
                        splashProvider.currentPage < sliderItems.length - 1
                            ? 'Continue'
                            : 'Get Started',
                        style: SplashStyles.buttonTextStyle(isNarrowScreen),
                      ),
                    ),
                  ),
                  SizedBox(height: isVerySmallScreen ? 10 : 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}