import 'dart:convert';

import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  int id;
  String username;
  String email;

  User(
    this.id,
    this.username,
    this.email,
  );
}
