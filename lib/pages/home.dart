import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sum_parking/pages/create_reservation.dart';
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/providers/parking_space.dart';
import 'package:sum_parking/providers/parking_spaces.dart';
import 'package:sum_parking/providers/reservations.dart';
import '../widgets/parking_space.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selParking = "skripta";


  var _isInit = true;
  bool _isLoading = false;
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final skripta = Provider.of<ParkingSpaces>(context).findSkripta();
    final igraliste = Provider.of<ParkingSpaces>(context).findIgraliste();
    final glavni = Provider.of<ParkingSpaces>(context).findGlavni();


    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 5.0),
              child: CarouselSlider(
                height: MediaQuery.of(context).size.height * 0.3,
                items: ['skripta', 'glavni', 'igraliste'].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          setState(() {  
                          selParking = i;
                          });
                        },
                                              child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            image: DecorationImage(
                              image: AssetImage("images/sum_$i.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * 0.7) - 110.0,
              child: _buildChld(selParking,skripta,igraliste,glavni)
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildChld(selParking,skripta,igraliste,glavni){
  if (selParking == "glavni") {
    return  ListView.builder(
                  itemCount: glavni.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => ParkingSpaceItem(Provider.of<ParkingSpaces>(context).findGlavni()[index]));
  }
  else if (selParking == "skripta"){
    return  ListView.builder(
                  itemCount: skripta.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => ParkingSpaceItem(Provider.of<ParkingSpaces>(context).findSkripta()[index]));
  }
  else{
    return  ListView.builder(
                  itemCount: igraliste.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => ParkingSpaceItem(Provider.of<ParkingSpaces>(context).findIgraliste()[index]));
  }
}