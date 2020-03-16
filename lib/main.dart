import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/pages/registration.dart';
import 'pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_parking/pages/create_reservation.dart';
import './pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SUM sParking",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        primaryColor: Colors.lightBlue[100],
        //accentColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.lightBlue[100],
      ),
      routes: {
        Registration.routeName : (ctx)=> Registration(),
        ParkingInformation.routeName : (ctx)=> ParkingInformation(),
        CreateReservation.routeName: (ctx)=> CreateReservation(),

      },
    );
  }
}