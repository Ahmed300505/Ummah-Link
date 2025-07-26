import 'package:flutter/material.dart';
import 'package:islamicinstapp/styles/colors.dart';
import 'package:islamicinstapp/styles/text_styles.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({ Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation < Offset > _topRightImageAnimation;
  late Animation < Offset > _bottomLeftImageAnimation;
  late Animation < double > _fadeOutAnimation;
  late Animation < double > _tickScaleAnimation;
  late Animation < double > _textFadeAnimation;
  late Animation < double > _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // Top-right image (Vector) slides diagonally to center with proper spacing
    _topRightImageAnimation = Tween < Offset > (
      begin: const Offset(1.5, -1.5),
      end: const Offset(0.3, -0.3), // Adjusted to stop before exact center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Bottom-left image (Group) slides diagonally to center with proper spacing
    _bottomLeftImageAnimation = Tween < Offset > (
      begin: const Offset(-1.5, 1.5),
      end: const Offset(-0.3, 0.3), // Adjusted to stop before exact center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    // Images fade out after joining
    _fadeOutAnimation = Tween < double > (begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.8, curve: Curves.easeIn),
      ),
    );

    // Tick scale animation with bounce
    _tickScaleAnimation = TweenSequence < double > ([
      TweenSequenceItem(tween: Tween < double > (begin: 0, end: 1.3), weight: 0.5),
      TweenSequenceItem(tween: Tween < double > (begin: 1.3, end: 0.9), weight: 0.2),
      TweenSequenceItem(tween: Tween < double > (begin: 0.9, end: 1.05), weight: 0.2),
      TweenSequenceItem(tween: Tween < double > (begin: 1.05, end: 1), weight: 0.1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 0.95, curve: Curves.ease),
      ),
    );

    // Text fade in
    _textFadeAnimation = Tween < double > (begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Opacity animation for smooth transitions
    _opacityAnimation = Tween < double > (begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 375;
    final imageSize = isSmallScreen ? 70.0 : 90.0;
    final tickSize = isSmallScreen ? 120.0 : 150.0;
    final imageOffset = isSmallScreen ? 35.0 : 45.0; // Increased offset for more spacing

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFFFCF5DB),
          body: SafeArea(
            child: SizedBox.expand(
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated checkmark parts with more spacing
                    Positioned(
                      height: imageSize * 3, // Increased container size
                      width: imageSize * 3,
                      child: Opacity(
                        opacity: _fadeOutAnimation.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(
                                _topRightImageAnimation.value.dx * imageOffset,
                                _topRightImageAnimation.value.dy * imageOffset - 30, // Added +10 to move Group.png slightly down
                              ),
                              child: Image.asset(
                                'assets/images/Vector.png',
                                width: imageSize * 0.9,
                                height: imageSize * 0.9,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Bottom-left image (Vector) - adjusted position
                            Transform.translate(
                              offset: Offset(
                                _bottomLeftImageAnimation.value.dx * imageOffset,
                                _bottomLeftImageAnimation.value.dy * imageOffset - 30, // Added -10 to move Vector.png slightly up
                              ),
                              child: Image.asset(
                                'assets/images/Group.png',
                                width: imageSize * 0.9,
                                height: imageSize * 0.9,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

// Rest of the code remains same...
// Final tick animation with glow
                    if (_tickScaleAnimation.value > 0)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(
                                  0.3 * _textFadeAnimation.value),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Transform.scale(
                          scale: _tickScaleAnimation.value,
                          child: Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: tickSize,
                          ),
                        ),
                      ),

                    // Success text with subtle drop shadow
                    Positioned(
                      bottom: screenSize.height * 0.35,
                      child: Opacity(
                        opacity: _textFadeAnimation.value,
                        child: Text(
                          'Link Secured Alhamdulillah',
                          style: TextStyles.registerTitleText(context).copyWith(
                            fontSize: isSmallScreen ? 17 : 23,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3)),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
