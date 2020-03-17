import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './reservation.dart';

class Reservations with ChangeNotifier {
  List<Reservation> _items = [];

  final String authToken;
  // final int user_id;

  Reservations(this._items, this.authToken);

  List<Reservation> get items {
    return [..._items];
  }

  Reservation findById(String id) {
    return _items.firstWhere((res) => res.id == id);
  }

  Reservation findPastById(String id) {
    return _items.firstWhere((res) =>
        res.id == id &&
        (DateTime.parse(res.reservation_time).isBefore(DateTime.now())));
  }

  Reservation findNextById(String id) {
    return _items.firstWhere((res) =>
        res.id == id &&
        (DateTime.parse(res.reservation_time).isAfter(DateTime.now())));
  }

  Future<void> fetchReservations([bool filterByUser = false]) async {
    var url = 'https://sum-parking.herokuapp.com/api/rezervations';
    final response = await http.get(url);
    final dataF = json.decode(response.body);
    final data = dataF['data'] as List;
    // print(data);
    final List<Reservation> reservations = [];
    if (data == null) {
      return;
    }
    data.forEach((dynamic) {
      // print(DateTime.parse(dynamic['rezervation_time']));

      reservations.add(
        Reservation(
          id: dynamic['id'],
          parking_space_id: dynamic['parking_space_id'],
          reservation_time: dynamic['rezervation_time'],
          user_id: dynamic['user_id'],
        ),
      );
    });
    _items = reservations;
    // print(_items);
    notifyListeners();
  }

  Future<void> addReservation(res) async {
    print(res);
    final url = 'https://sum-parking.herokuapp.com/api/rezervations';
    final response = await http.post(
      url,
      body: json.encode(res),
    );
    res = json.encode(res);
    print(res);
    final newReservation = Reservation(
      parking_space_id: res['parkingId'],
      reservation_time: res['rezervationTime'],
      user_id: res['userId'],
    );
    _items.add(newReservation);
    // notifyListeners();
  }

  Future<void> deleteReservation(int id) async {
    final url = '';
    final existingResIndex = _items.indexWhere((res) => res.id == id);
    var existRes = _items[existingResIndex];
    _items.removeAt(existingResIndex);
    notifyListeners();
    final response = await http.post(url);

    if (response.statusCode >= 400) {
      _items.insert(existingResIndex, existRes);
      notifyListeners();
    }
    existRes = null;
  }
}
