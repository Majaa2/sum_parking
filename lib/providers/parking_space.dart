import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class ParkingSpace with ChangeNotifier{
  final int id;
  final bool occupied;
  final double lat;
  final double lng;
  final String parkingType; 
  final String parkingSpaceTag;
  final String parkingSide;
  final bool is_visible;


ParkingSpace({
  @required this.id,
  @required this.occupied,
  @required this.lat,
  @required this.lng,
  @required this.parkingType,
  @required this.parkingSpaceTag,
  @required this.parkingSide,
  @required this.is_visible
  }
);
}