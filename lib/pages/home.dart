import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sum_parking/pages/create_reservation.dart';
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/providers/parking_spaces.dart';
import 'package:sum_parking/providers/reservations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var glavni = [];

  var skripta = [];

  var igraliste = [];
  var _isInit = true;
  bool _isLoading = false;
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ParkingSpaces>(context).fetchParkingSpaces().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // var parkingSpaces;

  // Future<String> getData() async {
  //   http.Response response = await http.get(
  //       Uri.encodeFull('http://smart.sum.ba/parking?withParkingSpaces=1'),
  //       headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     parkingSpaces = json.decode(response.body);
  //     parkingSpaces = parkingSpaces[0]['parkingSpaces'];
  //     var parkingSpace = {};
  //     parkingSpaces.forEach((space) => {
  //           if (space['id'] < 20)
  //             {
  //               parkingSpace = {
  //                 'id': space['id'],
  //                 'occupied': space['occupied'],
  //                 'lat': space['lat'],
  //                 'lng': space['lng'],
  //                 'parkingType': space['type'],
  //                 'parkingSpaceTag': 'S-' + space['id'].toString(),
  //                 'parkingSide': 'Skripta',
  //                 'is_visible': space['is_visible']
  //               },
  //               skripta.add(parkingSpace),
  //               // print(parkingSpace)
  //             }
  //           else if (space['id'] > 20 && space['id'] < 40)
  //             {
  //               parkingSpace = {
  //                 'id': space['id'],
  //                 'occupied': space['occupied'],
  //                 'lat': space['lat'],
  //                 'lng': space['lng'],
  //                 'parkingType': space['type'],
  //                 'parkingSpaceTag': 'I-' + space['id'].toString(),
  //                 'parkingSide': 'Igralište',
  //                 'is_visible': space['is_visible']
  //               },
  //               igraliste.add(parkingSpace)
  //             }
  //           else
  //             {
  //               parkingSpace = {
  //                 'id': space['id'],
  //                 'occupied': space['occupied'],
  //                 'lat': space['lat'],
  //                 'lng': space['lng'],
  //                 'parkingType': space['type'],
  //                 'parkingSpaceTag': 'G-' + space['id'].toString(),
  //                 'parkingSide': 'Glavni',
  //                 'is_visible': space['is_visible']
  //               },
  //               glavni.add(parkingSpace)
  //             }
  //         });
  //     print(glavni);
  //     print(igraliste);
  //     print(skripta);
  //   }
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
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
              height: (MediaQuery.of(context).size.height * 0.7) - 110.0,
              child: ListView.builder(
                  itemCount: 25,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ParkingInformation.routeName);
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                          title: Text('Parking space'),
                          subtitle: Text('Parking spot'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.local_parking,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(CreateReservation.routeName);
                            },
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
