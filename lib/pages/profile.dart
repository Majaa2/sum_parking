import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sum_parking/pages/home.dart';
import 'package:sum_parking/pages/main_page.dart';
import 'package:sum_parking/pages/parking_information.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sum_parking/providers/auth.dart';
import 'package:sum_parking/providers/reservations.dart';
import 'package:sum_parking/widgets/reservation_item.dart';
import './login_page.dart';
import '../widgets/cover_image.dart';
import '../widgets/profile_photo.dart';
import 'parking_information.dart';
import 'dart:async';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var items = 'past';
  var _isInit = true;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Reservations>(context).fetchReservations().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final futureResevationData = Provider.of<Reservations>(context)
        .findNextById(Provider.of<Auth>(context).userId);
    final pastResevationData = Provider.of<Reservations>(context)
        .findPastById(Provider.of<Auth>(context).userId);
    final email = Provider.of<Auth>(context).eMail;
    final user = Provider.of<Auth>(context).user;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[900], Colors.blue[600]])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 50,
                      backgroundColor: Colors.blue[800],
                      child: InkWell(
                        onLongPress: () => _onLongPress(),
                        child: CircleAvatar(
                          child: Text(user[0].toUpperCase(),
                              style: TextStyle(fontSize: 40.0)),
                          minRadius: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            // height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.lightBlue[300],
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          items = 'future';
                        });
                      },
                      title: Text(
                        "Trenutne rezervacije",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      subtitle: Text(
                        "${futureResevationData.length}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue[500], Colors.blue[800]])),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          // print('change');
                          items = 'past';
                        });
                      },
                      title: Text(
                        "Povijest rezervacija",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      subtitle: Text(
                        "${pastResevationData.length}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              itemCount: items == 'past'
                  ? pastResevationData.length
                  : futureResevationData.length,
              itemBuilder: items == 'past'
                  ? (ctx, i) => ReservationItem(
                      pastResevationData[i].id,
                      pastResevationData[i].user_id,
                      pastResevationData[i].parking_space_id,
                      pastResevationData[i].reservation_time)
                  : (ctx, i) => ReservationItem(
                      futureResevationData[i].id,
                      futureResevationData[i].user_id,
                      futureResevationData[i].parking_space_id,
                      futureResevationData[i].reservation_time),
            ),
          )
        ],
      ),
    );
  }

  void _onLongPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Card(
            color: Colors.red,
            child: ListTile(
              title: Text("Odjava"),
              onTap: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');

              Provider.of<Auth>(context).logout();
            },
            ),
          );
        });
  }
}

class Products {}
