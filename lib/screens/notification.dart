import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/notification_provider.dart';
import 'package:islamicinstapp/Styles/notification_styles.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NotificationStyles.backgroundColor,
      appBar: _buildAppBar(context),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: NotificationStyles.pagePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTodaySection(context, provider),
                const SizedBox(height: 16),
                _buildThisWeekSection(context, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: NotificationStyles.backgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: MediaQuery.of(context).size.width < 375 ? 20 : 24,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
      ),
      title: Text(
        'Notifications',
        style: NotificationStyles.appBarTitleTextStyle(context),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _buildTodaySection(BuildContext context, NotificationProvider provider) {
    final todayNotifications = provider.getTodayNotifications();
    if (todayNotifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Today', context),
        const SizedBox(height: 8),
        _buildNotificationList(context, todayNotifications),
      ],
    );
  }

  Widget _buildThisWeekSection(BuildContext context, NotificationProvider provider) {
    final weekNotifications = provider.getThisWeekNotifications();
    if (weekNotifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('This Week', context),
        const SizedBox(height: 8),
        _buildNotificationList(context, weekNotifications),
      ],
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 375 ? 4.0 : 8.0,
      ),
      child: Text(
        title,
        style: NotificationStyles.sectionHeaderTextStyle(context),
      ),
    );
  }

  Widget _buildNotificationList(
      BuildContext context,
      List<Map<String, String>> notifications,
      ) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notifications.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: NotificationStyles.borderColor,
      ),
      itemBuilder: (context, index) {
        return _buildNotificationItem(context, notifications[index]);
      },
    );
  }

  Widget _buildNotificationItem(
      BuildContext context,
      Map<String, String> notification,
      ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: NotificationStyles.splashColor.withOpacity(0.1),
        highlightColor: NotificationStyles.splashColor.withOpacity(0.05),
        child: Container(
          padding: NotificationStyles.notificationPadding(context),
          child: Row(
            children: [
              // Image icon
              Container(
                width: NotificationStyles.notificationImageSize(context),
                height: NotificationStyles.notificationImageSize(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(notification['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Notification Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['title']!,
                      style: NotificationStyles.notificationTitleTextStyle(context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['subtitle']!,
                      style: NotificationStyles.notificationSubtitleTextStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}