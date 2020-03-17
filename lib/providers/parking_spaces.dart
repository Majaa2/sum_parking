import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './parking_space.dart';

class ParkingSpaces with ChangeNotifier {
  List<ParkingSpace> _items = [];

  final String authToken;
  final int user_id;

  ParkingSpaces(this._items, this.authToken, this.user_id);

  List<ParkingSpace> get items {
    return [..._items];
  }

  ParkingSpace findById(String id) {
    return _items.firstWhere((res) => res.id == id);
  }

  Future<void> fetchParkingSpaces([bool filterByUser = false]) async {
    var url = '';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    final List<ParkingSpace> parking_spaces = [];
    if (data == null) {
      return;
    }
    data.forEach((id, data) {
      parking_spaces.add(ParkingSpace(
          id: data['id'],
          occupied: data['occupied'],
          lat: data['lat'],
          lng: data['lng'],
          parkingType: data['parkingType'],
          parkingSpaceTag: data['parkingSpaceTag'],
          parkingSide: data['parkingSide'],
          is_visible: data['is_visible']
          ));
    });
    _items = parking_spaces;
    notifyListeners();
  }

  Future<void> addParkingSpace(ParkingSpace parking_space) async {
    final url = '';
    final reposne = await http.post(
      url,
      body: jsonEncode({
        'occupied': parking_space.occupied,
        'lat': parking_space.lat,
        'lng': parking_space.lng,
        'parkingType':parking_space.parkingType,
        'parkingSpaceTag':parking_space.parkingSpaceTag,
        'parkingSide':parking_space.parkingSide,
        'is_visible':parking_space.is_visible
      }),
    );
    final newParkingSpace = ParkingSpace(
      occupied: parking_space.occupied,
      lat: parking_space.lat,
      lng: parking_space.lng,
      parkingType: parking_space.parkingType,
      parkingSpaceTag: parking_space.parkingSpaceTag,
      parkingSide: parking_space.parkingSide,
      is_visible: parking_space.is_visible
    );
    _items.add(newParkingSpace);
    notifyListeners();
  }

  Future<void> deleteParkingSpace(int id) async{
    final url ='';
    final existingSpaceIndex = _items.indexWhere((res) => res.id == id);
    var existSpace = _items[existingSpaceIndex];
    _items.removeAt(existingSpaceIndex);
    notifyListeners();
    final response = await http.post(url);

    if(response.statusCode >= 400){
        _items.insert(existingSpaceIndex, existSpace);
        notifyListeners();
      }
      existSpace = null;
  }
}
