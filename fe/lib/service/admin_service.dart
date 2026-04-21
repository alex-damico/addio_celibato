import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminService extends ChangeNotifier {
  final SharedPreferences _prefs;
  bool _isAdmin;

  AdminService(this._prefs) : _isAdmin = _prefs.getBool('is_admin') ?? false;

  bool get isAdmin => _isAdmin;

  Future<void> toggleAdmin() async {
    _isAdmin = !_isAdmin;
    await _prefs.setBool('is_admin', _isAdmin);
    notifyListeners();
  }
}
