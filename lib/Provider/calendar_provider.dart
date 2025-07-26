// calendar_provider.dart
import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  void setSelectedDay(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  List<Map<String, String>> getUpcomingEvents() {
    return [
      {'date': '18', 'time': '6:00 PM - 8:00 PM', 'title': 'Community Gathering'},
      {'date': '20', 'time': '2:00 PM - 3:00 PM', 'title': 'Al-Amaan: Sisters Biweekly Halaqa'},
      {'date': '24', 'time': '7:00 PM - 8:30 PM', 'title': 'SMIC Masjid: Tafsir Halaqa'},
    ];
  }

  List<Map<String, String>> getAllEvents() {
    return [
      {'date': '18', 'time': '6:00 PM - 8:00 PM', 'title': 'Community Gathering'},
      {'date': '20', 'time': '2:00 PM - 3:00 PM', 'title': 'Al-Amaan: Sisters Biweekly Halaqa'},
      {'date': '24', 'time': '7:00 PM - 8:30 PM', 'title': 'SMIC Masjid: Tafsir Halaqa'},
      {'date': '26', 'time': '5:00 PM - 6:00 PM', 'title': 'Youth Quran Circle'},
      {'date': '28', 'time': '1:00 PM - 2:00 PM', 'title': 'Friday Khutbah Prep'},
      {'date': '30', 'time': '4:00 PM - 5:30 PM', 'title': 'Sisters Book Club'},
      {'date': '02', 'time': '6:00 PM - 7:30 PM', 'title': 'Ramadan Planning Session'},
      {'date': '04', 'time': '3:00 PM - 4:00 PM', 'title': 'Kids Islamic Quiz'},
      {'date': '06', 'time': '7:00 PM - 9:00 PM', 'title': 'Monthly Community Dinner'},
    ];
  }
}