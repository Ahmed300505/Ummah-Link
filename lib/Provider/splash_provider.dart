// splash_provider.dart
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _showDescription = false;
  bool _showSlider = false;
  int _currentPage = 0;

  bool get showDescription => _showDescription;
  bool get showSlider => _showSlider;
  int get currentPage => _currentPage;

  void setShowDescription(bool value) {
    _showDescription = value;
    notifyListeners();
  }

  void setShowSlider(bool value) {
    _showSlider = value;
    notifyListeners();
  }

  void setCurrentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}