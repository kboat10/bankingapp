import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  Map<String, UserModel> _users = {};
  
  // Getter for current user
  UserModel? get currentUser => _currentUser;
  
  // Getter for all users (for debugging/testing)
  Map<String, UserModel> get users => _users;
  
  // Check if user exists
  bool userExists(String name) {
    return _users.containsKey(name.toLowerCase());
  }
  
  // Register a new user
  bool registerUser(String name, String password, {String? email}) {
    final key = name.toLowerCase();
    
    if (_users.containsKey(key)) {
      return false; // User already exists
    }
    
    final newUser = UserModel(
      name: name,
      password: password,
      email: email,
      createdAt: DateTime.now(),
    );
    
    _users[key] = newUser;
    notifyListeners();
    return true;
  }
  
  // Authenticate user
  bool authenticateUser(String name, String password) {
    final key = name.toLowerCase();
    final user = _users[key];
    
    if (user != null && user.password == password) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    
    return false;
  }
  
  // Logout user
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
  
  // Set user (for backward compatibility)
  void setUser(String name) {
    final key = name.toLowerCase();
    if (_users.containsKey(key)) {
      _currentUser = _users[key];
      notifyListeners();
    }
  }
  
  // Get user by name
  UserModel? getUser(String name) {
    return _users[name.toLowerCase()];
  }
} 