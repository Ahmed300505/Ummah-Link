import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/Provider/add_post_provider.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:islamicinstapp/Styles/colors.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddPostProvider(),
      child: const _AddPostScreenContent(),
    );
  }
}

class _AddPostScreenContent extends StatelessWidget {
  const _AddPostScreenContent();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 375;
    final provider = Provider.of<AddPostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 28, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Post',
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 20,
                  vertical: isSmallScreen ? 8 : 10,
                ),
              ),
              onPressed: provider.isLoading ? null : () => provider.submitPost(context),
              child: provider.isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                'Post',
                style: TextStyles.addPostAppBarButtonText(context),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community Dropdown
            _buildCommunityDropdown(context, provider, isSmallScreen),
            const SizedBox(height: 24),

            // Title Field
            Text(
              'Title',
              style: TextStyles.addPostLabelText(context),
            ),
            const SizedBox(height: 8),
            _buildTitleField(context, provider),

            const SizedBox(height: 20),

            // Content Field
            Text(
              'Content',
              style: TextStyles.addPostLabelText(context),
            ),
            const SizedBox(height: 8),
            _buildContentField(context, provider),

            const SizedBox(height: 20),

            // Image Picker
            _buildImagePicker(context, provider),

            const SizedBox(height: 20),

            // Selected Community Preview
            if (provider.selectedCommunity != null)
              _buildCommunityPreview(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityDropdown(
      BuildContext context, AddPostProvider provider, bool isSmallScreen) {
    return Container(
      width: isSmallScreen ? 230 : 260,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(39),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: provider.selectedCommunity,
        hint: Text(
          'Select a community',
          style: TextStyles.addPostDropdownText(context),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          size: 24,
        ),
        dropdownColor: AppColors.primary,
        style: TextStyles.addPostDropdownText(context),
        items: provider.communities.map((community) {
          return DropdownMenuItem<String>(
            value: community['name'],
            child: Row(
              children: [
                Image.asset(
                  community['image'],
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 24,
                      height: 24,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    community['name'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.addPostDropdownText(context),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: provider.selectCommunity,
      ),
    );
  }

  Widget _buildTitleField(BuildContext context, AddPostProvider provider) {
    return TextField(
      controller: provider.titleController,
      decoration: InputDecoration(
        hintText: 'Enter post title...',
        hintStyle: TextStyles.addPostHintText(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      maxLength: 100,
    );
  }

  Widget _buildContentField(BuildContext context, AddPostProvider provider) {
    return TextField(
      controller: provider.contentController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Write your post content here...',
        hintStyle: TextStyles.addPostHintText(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, AddPostProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Image (Optional)',
          style: TextStyles.addPostLabelText(context),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: provider.isUploading ? null : () => provider.pickImage(),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: provider.isUploading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.imageFile != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(provider.imageFile!.path),
                fit: BoxFit.cover,
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color: Colors.grey[500],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap to add image',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
        if (provider.imageFile != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(
              onPressed: () {
                provider.notifyListeners();
              },
              child: Text(
                'Remove image',
                style: TextStyle(
                  color: Colors.red[400],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCommunityPreview(
      BuildContext context, AddPostProvider provider) {
    final community = provider.communities.firstWhere(
          (c) => c['name'] == provider.selectedCommunity,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview for ${provider.selectedCommunity}',
          style: TextStyles.addPostLabelText(context),
        ),
        const SizedBox(height: 8),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              community['image'],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'No image',
                      style: TextStyles.addPostHintText(context),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}