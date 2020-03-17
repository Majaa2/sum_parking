import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './user.dart';

class Auth with ChangeNotifier {
  String _authToken;
  User user;

  String get authToken {
    return _authToken;
  }

  bool get isAuth {
    return authToken != null;
  }

  int get user_id {
    return user.id;
  }

  Future<void> _authenticate(String username, String password) async {
    final url = '"https://sum-parking.herokuapp.com/api/login';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'username': username,
          'password': password,
        },
      ),
    );

    final responseData = json.decode(response.body);

    if (responseData['success']) {
      _authToken = responseData['data']['token'];
      // user = responseData['data']['user'];
      user = User(
        responseData['data']['user']['id'],
        responseData['data']['user']['username'],
        responseData['data']['user']['email'],
      );
    }
  }

  // Future<void> singup(String username, String password) async {
  //   return _authenticate(username, password);
  // }

  Future<void> singin(String username, String password) async {
    return _authenticate(username, password);
  }

   Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;

    if (extractedUserData['token'] !='') {
      return false;
    }
    _authToken = extractedUserData['token'];
    user = extractedUserData['user'];
    notifyListeners();
    _autoLogout();
    return true;
  }

   Future<void> logout() async {
    _authToken = null;
    user = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    logout();
  }
}
