import 'package:flutter/material.dart';
import 'package:myapp/services/authentication_service.dart';

class AuthenticationController extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthenticationController() {
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    _isLoggedIn = await _authenticationService.isLoggedIn();
    notifyListeners();
  }

  Future<void> login() async {
    await _authenticationService.login();
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    _isLoggedIn = false;
    notifyListeners();
  }
}