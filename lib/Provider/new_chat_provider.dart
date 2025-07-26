// new_chat_provider.dart
import 'package:flutter/material.dart';

class NewChatProvider with ChangeNotifier {
  List<Map<String, dynamic>> _contacts = [
    {
      'avatar': 'A',
      'name': 'Ali Khan',
      'description': 'Last seen today at 2:30 PM',
      'isOnline': false,
    },
    {
      'avatar': 'F',
      'name': 'Fatima Ahmed',
      'description': 'Online',
      'isOnline': true,
    },
    {
      'avatar': 'D',
      'name': 'DarAlFaroog Community',
      'description': '68 members',
      'isGroup': true,
    },
    {
      'avatar': 'N',
      'name': 'Nassira J',
      'description': 'Active 5 minutes ago',
      'isOnline': false,
    },
    {
      'avatar': 'S',
      'name': 'Salma X',
      'description': 'Last seen yesterday',
      'isOnline': false,
    },
    {
      'avatar': 'Q',
      'name': 'Quran Study Group',
      'description': '120 members',
      'isGroup': true,
    },
    {
      'avatar': 'I',
      'name': 'Islamic Finance',
      'description': '45 members',
      'isGroup': true,
    },
    {
      'avatar': 'M',
      'name': 'Mohammed Y',
      'description': 'Online',
      'isOnline': true,
    },
  ];

  List<Map<String, dynamic>> get contacts => _contacts;

  void addContact(Map<String, dynamic> contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void searchContacts(String query) {
    // Implement search functionality
    notifyListeners();
  }
}