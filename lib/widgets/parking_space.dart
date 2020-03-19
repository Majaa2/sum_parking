import 'package:flutter/material.dart';
import 'package:sum_parking/pages/create_reservation.dart';
import 'package:sum_parking/pages/parking_information.dart';
import 'package:sum_parking/providers/parking_spaces.dart';
import '../providers/parking_space.dart' as ps;

class ParkingSpaceItem extends StatefulWidget {
  final ps.ParkingSpace parkingSpace;
  ParkingSpaceItem(this.parkingSpace);

  @override
  _ParkingSpaceItemState createState() => _ParkingSpaceItemState();
}

class _ParkingSpaceItemState extends State<ParkingSpaceItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(ParkingInformation.routeName, arguments: widget.parkingSpace.id );
        },
        leading: CircleAvatar(
          backgroundColor: widget.parkingSpace.occupied == 1? Colors.red: Colors.green,
        ),
        title: Text('${widget.parkingSpace.parkingSpaceTag}'),
        subtitle: Text('${widget.parkingSpace.parkingSideName}'),
        trailing: IconButton(
          icon: Icon(
            Icons.local_parking,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CreateReservation.routeName, arguments: widget.parkingSpace.id );
          },
        ),
      ),
    );
  }
}
