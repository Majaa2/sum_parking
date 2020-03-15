import 'package:flutter/material.dart';
import '../models/diagonal_clipper.dart';

class CoverImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final  screenHeight = size.height;
    return ClipPath(
      clipper: DialogonalClipper(),
          child: Image.asset(
        'images/paris.jpg',
        fit: BoxFit.fitHeight,
        colorBlendMode: BlendMode.srcOver,
        color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }
}