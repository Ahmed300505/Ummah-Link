// messaging_provider.dart
import 'package:flutter/material.dart';

class MessagingProvider with ChangeNotifier {
  List<Map<String, dynamic>> _trendingChannels = [
    {
      'avatar': 'A',
      'name': 'EidFest.co',
      'description': "Who's excited for Eid...",
      'followers': '300 followers',
    },
    {
      'avatar': 'G',
      'name': 'GroundedTwinc',
      'description': "Monday Halay's",
      'followers': '250 followers',
    },
  ];

  List<Map<String, dynamic>> _forumItems = [
    {
      'avatar': 'A',
      'name': 'anonymous4087',
      'title': 'Best Quran School for Reverts?',
      'description': 'Asalamu Alaykum, I am a new muslim and I\'m looking for a place to learn the Quran for beginners...',
    },
    {
      'avatar': 'R',
      'name': 'rehabriye',
      'title': 'Is Indonesia a safe place for a muslim girl?',
      'description': 'Salaam! My name is Renab, I\'m traveling to Indonesia and I\'m a bit concerned with the overall safety. Does anyone know...',
    },
    {
      'avatar': 'D',
      'name': 'DarAlFaroogCommunity',
      'title': 'What time is Dar Al Faroog Qiyam?',
      'description': 'Does anyone know what time DFC usually has their tahajjud salah?...',
    },
    {
      'avatar': 'S',
      'name': 'salmaxx',
      'title': 'Is it impermissible to travel without a mahram?',
      'description': 'Salaam! My name is Salma, I was wondering if anyone could guide me on traveling without a mahram...',
    },
    {
      'avatar': 'S',
      'name': 'saidd...',
      'title': 'Navigating halal income',
      'description': 'Asalamu Alaykum, I\'m 22 years old and I want to purify in income while also growing it. I want to become wealthy but...',
    },
  ];

  int _notificationCount = 20;

  List<Map<String, dynamic>> get trendingChannels => _trendingChannels;
  List<Map<String, dynamic>> get forumItems => _forumItems;
  int get notificationCount => _notificationCount;

  void addTrendingChannel(Map<String, dynamic> channel) {
    _trendingChannels.add(channel);
    notifyListeners();
  }

  void addForumItem(Map<String, dynamic> item) {
    _forumItems.insert(0, item);
    notifyListeners();
  }

  void clearNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }
}