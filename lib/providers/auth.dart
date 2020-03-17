import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './user.dart';

class Auth with ChangeNotifier {
  String _authToken;
  int _user_id;
  String _username;
  String _email;


  String get authToken {
    return _authToken;
  }

  String get user {
    return _username;
  }

  String get eMail {
    return _email;
  }
  bool get isAuth {
    return authToken != null;
  }

  int get userId {
    return _user_id;
  }

  Future<void> _authenticate(String username, String password) async {
    final url = 'https://sum-parking.herokuapp.com/api/login';
    final response = await http.post(
      url,
      body:
        {
          'username': username,
          'password': password,
        },
    );
    final responseData = json.decode(response.body);
    // print(responseData['token']);

    if (responseData['success']) {
      print(responseData['data']['user']);
      _authToken = responseData['token'];
      _user_id= responseData['data']['user']['id'];
      _username = responseData['data']['user']['username'];
      _email =   responseData['data']['user']['email'];
    }
    print(authToken);
    print(user);
    print(eMail);
    notifyListeners();

    // final prefs = await SharedPreferences.getInstance();
    // print(json.decode(prefs.getString('_authToken')));
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
    // user = extractedUserData['user'];
    notifyListeners();
    _autoLogout();
    return true;
  }

   Future<void> logout() async {
    _authToken = null;
    _user_id = null;
    _username = null;
    _email = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    logout();
  }
}
