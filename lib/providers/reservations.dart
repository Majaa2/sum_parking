import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './reservation.dart';

class Reservations with ChangeNotifier {
  List<Reservation> _items = [];

  final String authToken;
  final int user_id;

  Reservations(this._items, this.authToken, this.user_id);

  List<Reservation> get items {
    return [..._items];
  }

  Reservation findById(String id) {
    return _items.firstWhere((res) => res.id == id);
  }

  Future<void> fetchReservations([bool filterByUser = false]) async {
    var url = '';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    final List<Reservation> reservations = [];
    if (data == null) {
      return;
    }
    data.forEach((id, data) {
      reservations.add(Reservation(
          id: data['id'],
          parking_space_id: data['parking_space_id'],
          reservation_time: data['reservation_time'],
          user_id: data['user_id']));
    });
    _items = reservations;
    notifyListeners();
  }

  Future<void> addReservation(Reservation reservation) async {
    final url = '';
    final reposne = await http.post(
      url,
      body: jsonEncode({
        'parking_space_id': reservation.parking_space_id,
        'reservation_time': reservation.reservation_time,
        'user_id': user_id
      }),
    );
    final newReservation = Reservation(
      parking_space_id: reservation.parking_space_id,
        reservation_time: reservation.reservation_time,
        user_id: user_id
    );
    _items.add(newReservation);
    notifyListeners();
  }

  Future<void> deleteReservation(int id) async{
    final url ='';
    final existingResIndex = _items.indexWhere((res) => res.id == id);
    var existRes = _items[existingResIndex];
    _items.removeAt(existingResIndex);
    notifyListeners();
    final response = await http.post(url);

    if(response.statusCode >= 400){
        _items.insert(existingResIndex, existRes);
        notifyListeners();
      }
      existRes = null;
  }
}
