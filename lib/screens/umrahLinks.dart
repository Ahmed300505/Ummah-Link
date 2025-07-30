import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/umrah_links_provider.dart';
import 'package:islamicinstapp/Service/ForyouService.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class UmrahLinks extends StatelessWidget {
  const UmrahLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UmrahLinksProvider(),
      child: const _UmrahLinksContent(),
    );
  }
}

class _UmrahLinksContent extends StatelessWidget {
  const _UmrahLinksContent();

  bool _isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 375;
  bool _isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 375 &&
          MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = _isSmallScreen(context);
    final isMediumScreen = _isMediumScreen(context);

    return Scaffold(
      backgroundColor: AppColors.umrahBackground,
      appBar: _buildAppBar(context, isSmallScreen, isMediumScreen),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12.0 :
          isMediumScreen ? 16.0 : 24.0,
          vertical: isSmallScreen ? 12.0 :
          isMediumScreen ? 16.0 : 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isSmallScreen, isMediumScreen),
            SizedBox(height: isSmallScreen ? 16 :
            isMediumScreen ? 20 : 24),
            _buildLinksGrid(context),
            SizedBox(height: isSmallScreen ? screenSize.height * 0.03 :
            isMediumScreen ? screenSize.height * 0.04 :
            screenSize.height * 0.05),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isSmallScreen, bool isMediumScreen) {
    return AppBar(
      backgroundColor: AppColors.umrahBackground,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: isSmallScreen ? 20 :
          isMediumScreen ? 22 : 24,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Umrah Links',
        style: TextStyles.umrahAppBarTitleText(context),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Text(
            'Skip',
            style: TextStyles.umrahSkipButtonText(context),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen, bool isMediumScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests',
          style: TextStyles.umrahTitleText(context),
        ),
        SizedBox(height: isSmallScreen ? 4 :
        isMediumScreen ? 6 : 8),
        Text(
          'Select the topics you\'re interested in to get personalized Umrah resources and guidance for your spiritual journey.',
          style: TextStyles.umrahDescriptionText(context),
        ),
      ],
    );
  }

  Widget _buildLinksGrid(BuildContext context) {
    final umrahProvider = Provider.of<UmrahLinksProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = _isSmallScreen(context);
    final isMediumScreen = _isMediumScreen(context);

    final crossAxisCount = isSmallScreen ? 2 :
    isMediumScreen ? 3 : 4;
    final buttonHeight = isSmallScreen ? screenSize.height * 0.06 :
    isMediumScreen ? screenSize.height * 0.055 :
    screenSize.height * 0.05;
    final buttonPadding = isSmallScreen ? 6.0 :
    isMediumScreen ? 8.0 : 10.0;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: isSmallScreen ? 8 :
        isMediumScreen ? 10 : 12,
        mainAxisSpacing: isSmallScreen ? 8 :
        isMediumScreen ? 10 : 12,
        childAspectRatio: isSmallScreen ? 2.8 :
        isMediumScreen ? 3.0 : 3.2,
      ),
      itemCount: umrahProvider.umrahLinks.length,
      itemBuilder: (context, index) {
        final link = umrahProvider.umrahLinks[index];
        return _buildLinkButton(
          context: context,
          title: link['title'] as String,
          isSelected: link['selected'] as bool,
          onTap: () => umrahProvider.toggleLinkSelection(index),
          height: buttonHeight,
          padding: buttonPadding,
        );
      },
    );
  }

  Widget _buildLinkButton({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required double height,
    required double padding,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: height,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.umrahButtonSelected : AppColors.umrahButtonUnselected,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.umrahButtonSelected : AppColors.umrahButtonBorder.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.umrahButtonText(context).copyWith(
                  color: isSelected ? Colors.white : AppColors.umrahText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    final umrahProvider = Provider.of<UmrahLinksProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = _isSmallScreen(context);
    final isMediumScreen = _isMediumScreen(context);

    if (umrahProvider.selectedCount != 4) {
      return const SizedBox.shrink();
    }

    return Center(
      child: SizedBox(
        width: isSmallScreen ? screenSize.width * 0.9 :
        isMediumScreen ? screenSize.width * 0.85 :
        screenSize.width * 0.8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.umrahButtonSelected,
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
            ),
            padding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? screenSize.height * 0.016 :
              isMediumScreen ? screenSize.height * 0.017 :
              screenSize.height * 0.018,
            ),
          ),
          onPressed: () async {
            final selectedItems = umrahProvider.getSelectedLinks();
            try {
              await ForYouService().saveForYouInterests(selectedItems);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to save interests: \$e')),
              );
            }
          },
          child: Text(
            'Continue',
            style: TextStyles.umrahContinueButtonText(context),
          ),
        ),
      ),
    );
  }
}