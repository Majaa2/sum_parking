import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sum_parking/providers/parking_space.dart';
import 'package:sum_parking/providers/parking_spaces.dart';

class ParkingInformation extends StatefulWidget {
  static const routeName = '/parking_information';

  @override
  _ParkingInformationState createState() => _ParkingInformationState();
}

class _ParkingInformationState extends State<ParkingInformation> {
  var zauzeto = false;

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;
    ParkingSpace parkingSpace =
        Provider.of<ParkingSpaces>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parkirno mjesto: ${parkingSpace.parkingSpaceTag}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Card(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(43.346279, 17.797821),
                zoom: 15,
              ),
              markers: {Marker(markerId: MarkerId('${parkingSpace.parkingSpaceTag}'), position: LatLng(parkingSpace.lat, parkingSpace.lng))},
            ),
          ),
        ),
        Container(
          color:
              parkingSpace.occupied == 1 ? Colors.red[200] : Colors.green[200],
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Parkirno mjesto: ${parkingSpace.parkingSpaceTag}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '${parkingSpace.parkingSideName}',
                        style:
                            TextStyle(fontSize: 17.0, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        parkingSpace.occupied == 1 ? "ZAUZETO" : "SLOBODNO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: parkingSpace.occupied == 1
                              ? Colors.red[700]
                              : Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
