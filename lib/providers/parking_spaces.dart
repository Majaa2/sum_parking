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

  ParkingSpace findaById(String id) {
    return _items.firstWhere((res) => res.id == id);
  }
  ParkingSpace findSkripta() {
    return _items.firstWhere((res) => res.parkingSide == 'skripta');
  }

  ParkingSpace findGlavni() {
    return _items.firstWhere((res) => res.parkingSide == 'glavni');
  }

  ParkingSpace findIgraliste() {
    return _items.firstWhere((res) => res.parkingSide == 'igraliste');
  }

  Future<void> fetchParkingSpaces([bool filterByUser = false]) async {
    var url = 'http://smart.sum.ba/parking?withParkingSpaces=1';
    final response = await http.get(url);
    final dataF = json.decode(response.body) as List;
    final data = dataF[0]['parkingSpaces'];
    // print();
    final List<ParkingSpace> parking_spaces = [];


    if (data == null) {
      return;
    }
    data.forEach((dynamic) {
      if (dynamic['id'] < 20) {
        parking_spaces.add(ParkingSpace(
            id: dynamic['id'],
            occupied: dynamic['occupied'],
            lat: dynamic['lat'],
            lng: dynamic['lng'],
            parkingType: dynamic['parkingType'],
            parkingSpaceTag: dynamic['parkingSpaceTag'],
            parkingSide: 'skripta',
            is_visible: dynamic['is_visible']));
        // print(parkingSpace)
      } else if (dynamic['id'] > 20 && dynamic['id'] < 40) {
        parking_spaces.add(ParkingSpace(
            id: dynamic['id'],
            occupied: dynamic['occupied'],
            lat: dynamic['lat'],
            lng: dynamic['lng'],
            parkingType: dynamic['parkingType'],
            parkingSpaceTag: dynamic['parkingSpaceTag'],
            parkingSide: 'igraliste',
            is_visible: dynamic['is_visible']));
      } else {
        parking_spaces.add(ParkingSpace(
            id: dynamic['id'],
            occupied: dynamic['occupied'],
            lat: dynamic['lat'],
            lng: dynamic['lng'],
            parkingType: dynamic['parkingType'],
            parkingSpaceTag: dynamic['parkingSpaceTag'],
            parkingSide: 'glavni',
            is_visible: dynamic['is_visible']));
      } 
      // print(parking_spaces);
    });
    _items = parking_spaces;
    notifyListeners();
  }

  // Future<void> addParkingSpace(ParkingSpace parking_space) async {
  //   final url = '';
  //   final reposne = await http.post(
  //     url,
  //     body: jsonEncode({
  //       'occupied': parking_space.occupied,
  //       'lat': parking_space.lat,
  //       'lng': parking_space.lng,
  //       'parkingType':parking_space.parkingType,
  //       'parkingSpaceTag':parking_space.parkingSpaceTag,
  //       'parkingSide':parking_space.parkingSide,
  //       'is_visible':parking_space.is_visible
  //     }),
  //   );
  //   final newParkingSpace = ParkingSpace(
  //     occupied: parking_space.occupied,
  //     lat: parking_space.lat,
  //     lng: parking_space.lng,
  //     parkingType: parking_space.parkingType,
  //     parkingSpaceTag: parking_space.parkingSpaceTag,
  //     parkingSide: parking_space.parkingSide,
  //     is_visible: parking_space.is_visible
  //   );
  //   _items.add(newParkingSpace);
  //   notifyListeners();
  // }

  // Future<void> deleteParkingSpace(int id) async{
  //   final url ='';
  //   final existingSpaceIndex = _items.indexWhere((res) => res.id == id);
  //   var existSpace = _items[existingSpaceIndex];
  //   _items.removeAt(existingSpaceIndex);
  //   notifyListeners();
  //   final response = await http.post(url);

  //   if(response.statusCode >= 400){
  //       _items.insert(existingSpaceIndex, existSpace);
  //       notifyListeners();
  //     }
  //     existSpace = null;
  // }
}
