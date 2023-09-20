// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.2756250, 0);
    path0.quadraticBezierTo(size.width * 0.1212500, size.height * 0.6235000,
        size.width * 0.0859375, size.height * 0.7655000);
    path0.quadraticBezierTo(size.width * 0.0303125, size.height * 0.9630000,
        size.width * 0.1259375, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width * 0.2756250, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
