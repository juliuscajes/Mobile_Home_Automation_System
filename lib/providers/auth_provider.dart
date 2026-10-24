import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/mock/mock_data.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  bool login(String email, String password) {
    if (password.length < 6) return false;
    try {
      _currentUser = MockData.users.firstWhere((u) => u.email == email);
    } catch (_) {
      _currentUser = UserModel(
        uid: 99,
        displayName: 'Guest User',
        email: email,
        role: 'Family Member',
        status: 'Approved',
      );
    }
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
