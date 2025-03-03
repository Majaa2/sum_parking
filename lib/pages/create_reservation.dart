import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sum_parking/providers/auth.dart';
import 'package:sum_parking/providers/parking_spaces.dart';
import 'package:sum_parking/providers/reservation.dart';
import 'package:sum_parking/providers/reservations.dart';

class CreateReservation extends StatefulWidget {
  static const routeName = '/add-reservation';

  @override
  _CreateReservationState createState() => _CreateReservationState();
}

class _CreateReservationState extends State<CreateReservation> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2020),
      lastDate: new DateTime(2222),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime() async {
    final TimeOfDay _picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (_picked != null) {
      setState(() {
        _time = _picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;
    var parkingSpace = Provider.of<ParkingSpaces>(context).findById(id);
    final user = Provider.of<Auth>(context).user;
    final userId = Provider.of<Auth>(context).userId;


    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Rezervirajte parking',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue[800],
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      _buildRowCard(Icons.my_location, Colors.blue, '${parkingSpace.parkingSpaceTag}',
                          'Parkirno mjesto'),
                      SizedBox(
                        width: 6.0,
                      ),
                      _buildRowCard(Icons.person_outline, Colors.purple, '${user}',
                          'Korisnik'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 15.0,
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 20.0,
                                      ),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white60,
                                    ),
                                    Text(DateFormat('yyyy-MM-dd').format(_date))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                          onPressed: () => _selectDate(),
                                          child: Text('Odaberi Datum'))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          color: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 15.0,
                                      child: Icon(
                                        Icons.timer,
                                        size: 20.0,
                                      ),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white60,
                                    ),
                                    Text(
                                      _time.format(context),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () => _selectTime(),
                                        child: Text('Odaberite vrijeme'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          color: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RawMaterialButton(
                    onPressed: () {
                      var res = {
                        "parkingId": id,
                        "userId": userId,
                        "rezervationTime": "${DateFormat('yyyy-MM-dd').format(_date)} ${_time.format(context)}+1"
                      };
                      Provider.of<Reservations>(context).addReservation(res);
                    },
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text('Rezerviraj',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Expanded _buildRowCard(IconData icon, Color color, String text, String title) {
  return Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 15.0,
                  child: Icon(
                    icon,
                    size: 20.0,
                  ),
                  backgroundColor: color,
                  foregroundColor: Colors.white70,
                ),
                Text(
                  text,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                title,
              ),
            )
          ],
        ),
      ),
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}
