import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var glavni = [];

  var skripta = [];

  var igraliste = [];

  var parkingSpaces;

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull('http://smart.sum.ba/parking?withParkingSpaces=1'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      parkingSpaces = json.decode(response.body);
      parkingSpaces = parkingSpaces[0]['parkingSpaces'];
      var parkingSpace = {};
      parkingSpaces.forEach((space) => {
            if (space['id'] < 20)
              {
                parkingSpace = {
                  'id': space['id'],
                  'occupied': space['occupied'],
                  'lat': space['lat'],
                  'lng': space['lng'],
                  'parkingType': space['type'],
                  'parkingSpaceTag': 'S-' + space['id'].toString(),
                  'parkingSide': 'Skripta',
                  'is_visible': space['is_visible']
                },
                skripta.add(parkingSpace),
                // print(parkingSpace)
              }
            else if (space['id'] > 20 && space['id'] < 40)
              {
                parkingSpace = {
                  'id': space['id'],
                  'occupied': space['occupied'],
                  'lat': space['lat'],
                  'lng': space['lng'],
                  'parkingType': space['type'],
                  'parkingSpaceTag': 'I-' + space['id'].toString(),
                  'parkingSide': 'Igralište',
                  'is_visible': space['is_visible']
                },
                igraliste.add(parkingSpace)
              }
            else
              {
                parkingSpace = {
                  'id': space['id'],
                  'occupied': space['occupied'],
                  'lat': space['lat'],
                  'lng': space['lng'],
                  'parkingType': space['type'],
                  'parkingSpaceTag': 'G-' + space['id'].toString(),
                  'parkingSide': 'Glavni',
                  'is_visible': space['is_visible']
                },
                glavni.add(parkingSpace)
              }
          });
      print(glavni);
      print(igraliste);
      print(skripta);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: CarouselSlider(
                height: 200.0,
                items: ['skripta', 'glavni', 'igraliste'].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
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
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.544,
              child: ListView.builder(
                itemCount: 25,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 40.0,
                                  height: 40.0,
                                  // color: Colors.green,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.green)),
                              SizedBox(width: 10.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'parking space',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'parking place',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(width: 100.0),
                              Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: FlatButton(
                                    onPressed: () {
                                      // Navigator.of(context).pushNamed(Somescreen.routeName);
                                    },
                                    color: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text('Rezerviraj', style: TextStyle(color: Colors.white)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
