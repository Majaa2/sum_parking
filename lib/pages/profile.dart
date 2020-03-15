import 'package:flutter/material.dart';
import '../widgets/cover_image.dart';
import '../widgets/profile_photo.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Column(
      children: <Widget>[
        Container(
          height: screenHeight * 0.4,
          child: Stack(
            children: <Widget>[
              CoverImage(),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    ProfilePhoto(),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
