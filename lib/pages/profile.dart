import 'package:flutter/material.dart';
import '../widgets/cover_image.dart';
import '../widgets/profile_photo.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var items = "reservationsNow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[900], Colors.blue[400]])),
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
                      child: CircleAvatar(
                        child: Text("M", style: TextStyle(fontSize: 40.0)),
                        minRadius: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ram Kumar",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(
                  "mail@gmail.com",
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
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.blue[700],
                          Colors.blue[400],
                        ])),
                    child: ListTile(
                      onTap: (){
                        items = 'reservationsNow';
                      },
                      title: Text(
                        "Trenutne rezervacije",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      subtitle: Text(
                        "Broj",
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
                      onTap: (){
                        items = 'reservationsOld';
                      },
                      title: Text(
                        "Povijest rezervacija",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      subtitle: Text(
                        "Broj",
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
            child: items == "reservationsNow"? Reservation(): ReservationOld(),
          )
        ],
      ),
    );
  }

  Container Reservation() {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 50),
              title: Text('Heart Shaker'),
              subtitle: Text('TWICE'),
            ),
          ],
        ),
      ),
    );
  }

  Container ReservationOld() {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 50),
              title: Text('Majaa'),
              subtitle: Text('Mala'),
            ),
          ],
        ),
      ),
    );
  }
}
