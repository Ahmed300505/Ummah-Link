// umrah_links_provider.dart
import 'package:flutter/material.dart';

class UmrahLinksProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _umrahLinks = [
    {'title': 'Preparation', 'selected': false},
    {'title': 'Packing List', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas Prayer', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas Prayer', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
    {'title': 'Preparation', 'selected': false},
    {'title': 'Packing List', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas Prayer', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas Prayer', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
    {'title': 'Travel Tips', 'selected': false},
    {'title': 'Makkah Guide', 'selected': false},
    {'title': 'Madinah Guide', 'selected': false},
    {'title': 'Duas Prayer', 'selected': false},
    {'title': 'Etiquette', 'selected': false},
  ];

  List<Map<String, dynamic>> get umrahLinks => _umrahLinks;
  int get selectedCount => _umrahLinks.where((item) => item['selected']).length;

  void toggleLinkSelection(int index) {
    if (_umrahLinks[index]['selected'] || selectedCount < 4) {
      _umrahLinks[index]['selected'] = !_umrahLinks[index]['selected'];
      notifyListeners();
    }
  }

  List<String> getSelectedLinks() {
    return _umrahLinks
        .where((item) => item['selected'] == true)
        .map((item) => item['title'] as String)
        .toList();
  }
}