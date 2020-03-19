import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/providers/auth.dart';
import 'package:sum_parking/providers/parking_spaces.dart';

class ReservationItem extends StatefulWidget {
  final int id;
  final int user_id;
  final int parking_space_id;
  var reservation_time;

  ReservationItem(
      this.id, this.user_id, this.parking_space_id, this.reservation_time);

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    final parkingSpace =
        Provider.of<ParkingSpaces>(context).findById(widget.parking_space_id);
    String date = widget.reservation_time;
    DateTime dateTime = DateTime.parse(date);
    setState(() {
      print(parkingSpace.id);
    });
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      parkingSpace.occupied == 0 ? Colors.green : Colors.red,
                ),
                title: Text(
                    "${parkingSpace.parkingSpaceTag} - ${parkingSpace.parkingSide}"),
                    subtitle: Text("${DateFormat("dd.MMMM yyyy HH:mm").format(dateTime)}"),
                onTap: () {
                  Navigator.of(context).pushNamed(ParkingInformation.routeName, arguments: parkingSpace.id);
                }),
          ],
        ),
      ),
    );
  }
}
