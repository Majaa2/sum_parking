import 'dart:ui';

import 'package:flutter/material.dart';

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo( 0.0, size.height - 90);
    path.lineTo(size.width, 60.0);
    path.lineTo(size.width , 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}