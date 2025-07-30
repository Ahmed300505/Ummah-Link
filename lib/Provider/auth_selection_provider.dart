import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSelectionProvider with ChangeNotifier {
  bool _isMemberSelected = true;
  String _selectedRole = 'member';

  bool get isMemberSelected => _isMemberSelected;
  String get selectedRole => _selectedRole;

  Future<void> selectMember() async {
    _isMemberSelected = true;
    _selectedRole = 'member';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedRole', _selectedRole);
    notifyListeners();
  }

  Future<void> selectLeader() async {
    _isMemberSelected = false;
    _selectedRole = 'leader';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedRole', _selectedRole);
    notifyListeners();
  }

  Future<void> loadSelectedRole() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedRole = prefs.getString('selectedRole') ?? 'member';
    _isMemberSelected = _selectedRole == 'member';
    notifyListeners();
  }
}
