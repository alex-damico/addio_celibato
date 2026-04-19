import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService extends ChangeNotifier {
  bool _isAdmin = false;

  bool get isAdmin => _isAdmin;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isAdmin = prefs.getBool('is_admin') ?? false;
    notifyListeners();
  }

  Future<void> toggleAdmin() async {
    _isAdmin = !_isAdmin;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_admin', _isAdmin);
    notifyListeners();
  }
}
