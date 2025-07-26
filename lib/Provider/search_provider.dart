// search_provider.dart
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _trendingItems = [
    {'icon': Icons.show_chart, 'text': 'Makkah Ziyarat Places'},
    {'icon': Icons.show_chart, 'text': 'Madinah Historical Sites'},
    {'icon': Icons.show_chart, 'text': 'Umrah Guide 2023'},
    {'icon': Icons.show_chart, 'text': 'Best Hotels Near Haram'},
    {'icon': Icons.show_chart, 'text': 'Islamic Lectures'},
    {'icon': Icons.show_chart, 'text': 'Quran Tafseer'},
    {'icon': Icons.show_chart, 'text': 'Dua Collections'},
  ];

  final List<Map<String, dynamic>> _communities = [
    {
      'logo': 'assets/images/islamiclogo.png',
      'title': 'Makkah Muslim Community',
      'description': 'Active community for pilgrims in Makkah',
      'mainImage': 'assets/images/searchimage1.png',
      'mapImage': 'assets/images/searchimage2.png',
      'mainImageTitle': 'Weekly Gathering',
      'mapTitle': 'Location',
    },
    {
      'logo': 'assets/images/islamiclogo2.png',
      'title': 'Madinah Study Circle',
      'description': 'Quran and Hadith study group',
      'mainImage': 'assets/images/searchimage1.png',
      'mapImage': 'assets/images/searchimage2.png',
      'mainImageTitle': 'Study Session',
      'mapTitle': 'Meeting Point',
    },
  ];

  List<Map<String, dynamic>> get trendingItems => _trendingItems;
  List<Map<String, dynamic>> get communities => _communities;
}