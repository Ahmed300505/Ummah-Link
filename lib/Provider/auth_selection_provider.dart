// auth_selection_provider.dart
import 'package:flutter/material.dart';

class AuthSelectionProvider with ChangeNotifier {
  bool _isMemberSelected = true;

  bool get isMemberSelected => _isMemberSelected;

  void selectMember() {
    _isMemberSelected = true;
    notifyListeners();
  }

  void selectLeader() {
    _isMemberSelected = false;
    notifyListeners();
  }
}