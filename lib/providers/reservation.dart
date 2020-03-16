import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Reservation with ChangeNotifier {
  final int id;
  final int parking_space_id;
  final int user_id;
  final DateTime reservation_time;

  Reservation({
    @required this.id,
    @required this.parking_space_id,
    @required this.user_id,
    @required this.reservation_time}
  );
}