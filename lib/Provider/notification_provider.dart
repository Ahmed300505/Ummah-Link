// notification_provider.dart
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<Map<String, String>> _notifications = [
    {
      'title': 'New Prayer Times Update',
      'subtitle': 'Updated prayer times for your location',
      'image': 'assets/images/event.jpg',
      'time': 'Today',
    },
    {
      'title': 'Islamic Event Reminder',
      'subtitle': 'Weekly Tafseer session starting soon',
      'image': 'assets/images/event2.jpg',
      'time': 'Today',
    },
    {
      'title': 'App Update Available',
      'subtitle': 'New version 2.3.1 ready to download',
      'image': 'assets/images/event3.jpg',
      'time': 'This Week',
    },
    {
      'title': 'Community Message',
      'subtitle': 'You have 3 new messages in the group',
      'image': 'assets/images/event4.jpg',
      'time': 'This Week',
    },
  ];

  List<Map<String, String>> get notifications => _notifications;

  List<Map<String, String>> getTodayNotifications() {
    return _notifications.where((n) => n['time'] == 'Today').toList();
  }

  List<Map<String, String>> getThisWeekNotifications() {
    return _notifications.where((n) => n['time'] == 'This Week').toList();
  }

  void addNotification(Map<String, String> notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void markAsRead(int index) {
    // Implement read status if needed
    notifyListeners();
  }
}