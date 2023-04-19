import 'package:chataapproutecourse/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Painter1 extends CustomPainter {
  Paint painter = Paint()
    ..color = PRIMARY_COLOR
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width - (size.width * 1 / 17), size.height * 1 / 4);
    path.lineTo(0, size.height);

    path.lineTo(-size.width * 1.09, -size.height * 1.6);

    canvas.drawPath(path, painter);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
