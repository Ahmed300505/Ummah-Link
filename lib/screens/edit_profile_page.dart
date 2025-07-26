// edit_profile_page.dart
// edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:islamicinstapp/Provider/edit_profile_provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(),
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Scaffold(
              backgroundColor: const Color(0xFFFEFDEB),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    if (provider.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          final mediaQuery = MediaQuery.of(context);
          final isPortrait = mediaQuery.orientation == Orientation.portrait;
          final safeAreaTop = mediaQuery.padding.top;
          final screenHeight = mediaQuery.size.height;
          final screenWidth = mediaQuery.size.width;

          return Scaffold(
            backgroundColor: const Color(0xFFFEFDEB),
            body: SafeArea(
              child: Stack(
                children: [
                  // Main Content (Non-Scrollable)
                  Column(
                    children: [
                      // Header Background
                      Container(
                        height: isPortrait ? screenHeight * 0.25 : screenWidth * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: provider.bannerImage.startsWith('http')
                                ? NetworkImage(provider.bannerImage)
                                : const AssetImage('assets/images/postimage3.jpg') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => provider.pickImage(isProfile: false),
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                      // Spacer for profile image overlap
                      SizedBox(height: isPortrait ? screenHeight * 0.12 - 60 : screenWidth * 0.12 - 60),
                      // Form Content
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: _EditForm(provider: provider),
                        ),
                      ),
                    ],
                  ),

                  // Back Button
                  Positioned(
                    top: safeAreaTop + 10,
                    left: 16,
                    child: _BackButton(),
                  ),

                  // Profile Image
                  Positioned(
                    top: (isPortrait ? screenHeight * 0.25 : screenWidth * 0.25) - 60,
                    left: 0,
                    right: 0,
                    child: _ProfileImage(provider: provider),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EditForm extends StatelessWidget {
  final EditProfileProvider provider;

  const _EditForm({required this.provider});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isPortrait ? 16 : mediaQuery.size.width * 0.15,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Edit Profile',
              style: TextStyles.editProfileTitleText(context).copyWith(
                color: const Color(0xFF033941),
                fontSize: isPortrait ? 24 : 28,
              ),
            ),
          ),
          SizedBox(height: isPortrait ? 24 : 32),

          // Name Field
          Text(
            'Name',
            style: TextStyles.editProfileLabelText(context)
                .copyWith(color: const Color(0xFF033941)),
          ),
          const SizedBox(height: 8),
          _CustomTextField(
            initialValue: provider.name,
            onChanged: provider.updateName,
          ),
          SizedBox(height: isPortrait ? 16 : 24),

          // Username Field
          Text(
            'Username',
            style: TextStyles.editProfileLabelText(context)
                .copyWith(color: const Color(0xFF033941)),
          ),
          const SizedBox(height: 8),
          _CustomTextField(
            initialValue: provider.username,
            onChanged: provider.updateUsername,
          ),
          SizedBox(height: isPortrait ? 16 : 24),

          // Bio Field
          Text(
            'Bio',
            style: TextStyles.editProfileLabelText(context)
                .copyWith(color: const Color(0xFF033941)),
          ),
          const SizedBox(height: 8),
          _CustomTextField(
            initialValue: provider.bio,
            onChanged: provider.updateBio,
            maxLines: 3,
          ),
          SizedBox(height: isPortrait ? 32 : 48),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: provider.isLoading ? null : () => provider.saveChanges(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF033941),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isPortrait ? 16 : 20,
                ),
                elevation: 3,
              ),
              child: provider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                'Save Changes',
                style: TextStyles.editProfileButtonText(context)
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          if (provider.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          // Bottom padding for safety
          SizedBox(height: mediaQuery.viewInsets.bottom > 0 ? mediaQuery.viewInsets.bottom : 20),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String initialValue;
  final Function(String) onChanged;
  final int maxLines;

  const _CustomTextField({
    required this.initialValue,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black),
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFEFDEB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final EditProfileProvider provider;

  const _ProfileImage({required this.provider});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final imageSize = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.width * 0.3
        : mediaQuery.size.height * 0.3;

    return Center(
      child: Stack(
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFEFDEB), width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: provider.profileImage.startsWith('http')
                  ? Image.network(
                provider.profileImage,
                fit: BoxFit.cover,
                width: imageSize,
                height: imageSize,
              )
                  : Image.asset(
                'assets/images/profilelogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => provider.pickImage(isProfile: true),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF033941),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
