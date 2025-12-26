

import 'package:flutter/material.dart';

class Trianglerclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)                    
      ..lineTo(size.width, 0)           
      ..lineTo(size.width / 2, size.height) 
      ..close();                        
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}