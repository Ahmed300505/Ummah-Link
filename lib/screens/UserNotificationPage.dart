import 'package:flutter/material.dart';

class UserNotificationPage extends StatefulWidget {
  const UserNotificationPage({super.key});

  @override
  State<UserNotificationPage> createState() => _UserNotificationPageState();
}

class _UserNotificationPageState extends State<UserNotificationPage> {
  bool messagesEnabled = false;
  bool groupInvitesEnabled = false;
  bool eventRemindersEnabled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    final padding = isSmall ? 16.0 : 20.0;
    final titleFontSize = isSmall ? 14.0 : 16.0;
    final subtitleFontSize = isSmall ? 11.0 : 13.0;
    final switchScale = isSmall ? 0.8 : 1.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFDEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFDEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Notifications are disabled for Ummah Link.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 231,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to enable notifications
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03B9C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Enable Notifications",style: TextStyle(fontSize: 15,color: Colors.white),),
              ),
            ),
            const SizedBox(height: 30),
            _buildSwitchTile(
              title: "Messages",
              subtitle: "Get notified when you receive new messages.",
              value: messagesEnabled,
              onChanged: (val) => setState(() => messagesEnabled = val),
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              switchScale: switchScale,
            ),
            _buildSwitchTile(
              title: "Group Invites",
              subtitle: "Receive alerts when someone invites you to join a new group.",
              value: groupInvitesEnabled,
              onChanged: (val) => setState(() => groupInvitesEnabled = val),
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              switchScale: switchScale,
            ),
            _buildSwitchTile(
              title: "Event Reminders",
              subtitle: "Stay updated with reminders for upcoming events and activities.",
              value: eventRemindersEnabled,
              onChanged: (val) => setState(() => eventRemindersEnabled = val),
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              switchScale: switchScale,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF033941),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required double titleFontSize,
    required double subtitleFontSize,
    required double switchScale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
              color: Colors.black,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: Colors.black54,
              ),
            ),
          ),
          trailing: Transform.scale(
            scale: switchScale,
            child: Switch(
              value: value,
              activeColor: const Color(0xFF03B9C2),
              onChanged: onChanged,
            ),
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
