// event_detail_provider.dart
import 'package:flutter/material.dart';

class EventDetailProvider with ChangeNotifier {
  final DateTime selectedDate;
  bool _isRegistered = false;
  int _attendeesCount = 75;

  EventDetailProvider({required this.selectedDate});

  bool get isRegistered => _isRegistered;
  int get attendeesCount => _attendeesCount;

  void toggleRegistration() {
    _isRegistered = !_isRegistered;
    if (_isRegistered) {
      _attendeesCount++;
    } else {
      _attendeesCount--;
    }
    notifyListeners();
  }

  void connectWithAttendees() {
    // Here you would typically implement connection logic
    // For now, we'll just show a snackbar in the UI
    notifyListeners();
  }
}