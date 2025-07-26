// forum_provider.dart
import 'package:flutter/material.dart';

class ForumProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _forumItems = [
    {
      'avatar': 'A',
      'name': 'anonymous4087',
      'title': 'Best Quran School for Reverts?',
      'description': 'Asalamu Alaykum, I am a new muslim and I\'m looking for a place to learn the Quran for beginners...',
      'badges': ['QURAN', 'COURSE', 'REVERT'],
      'likes': 54,
      'comments': 5,
    },
    {
      'avatar': 'R',
      'name': 'rehabriye',
      'title': 'Is Indonesia a safe place for a muslim girl?',
      'description': 'Salaam! My name is Renab, I\'m traveling to Indonesia and I\'m a bit concerned with the overall safety. Does anyone know...',
      'badges': ['TRAVEL', 'SISTERS'],
      'likes': 24,
      'comments': 3,
    },
    {
      'avatar': 'D',
      'name': 'DarAlFaroogCommunity',
      'title': 'What time is Dar Al Faroog Qiyam?',
      'description': 'Does anyone know what time DFC usually has their tahajjud salah?...',
      'badges': ['MASJID'],
      'likes': 20,
      'comments': 5,
    },
    {
      'avatar': 'S',
      'name': 'salmaxx',
      'title': 'Is it impermissible to travel without a mahram?',
      'description': 'Salaam! My name is Salma, I was wondering if anyone could guide me on traveling without a mahram...',
      'badges': ['TRAVEL', 'SISTERS'],
      'likes': 11,
      'comments': 3,
    },
    {
      'avatar': 'S',
      'name': 'saidd...',
      'title': 'Navigating halal income',
      'description': 'Asalamu Alaykum, I\'m 22 years old and I want to purify in income while also growing it. I want to become wealthy but...',
      'badges': ['FINANCE', 'BUSINESS'],
      'likes': 8,
      'comments': 2,
    },
  ];

  int _messageCount = 20;

  List<Map<String, dynamic>> get forumItems => _forumItems;
  int get messageCount => _messageCount;

  void clearMessages() {
    _messageCount = 0;
    notifyListeners();
  }
}