import 'package:flutter/material.dart';

import '../pages/profile.dart';

class ProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    return new Padding(
      padding: new EdgeInsets.only(left: 140.0, top: (screenHeight * 0.12) / 2.5),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 56.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Name',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'job title',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          new CircleAvatar(
            minRadius: 50.0,
            maxRadius: 50.0,
            backgroundImage: new AssetImage('images/keanu.jpg'),
          ),
        ],
      ),
    );
  }
}
