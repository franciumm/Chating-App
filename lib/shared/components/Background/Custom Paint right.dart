import 'package:chataapproutecourse/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Painter2 extends CustomPainter {
  Paint painter = Paint()
    ..color = SEC_COLOR
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(-(size.width - (size.width * 1.5 / 2)), size.height * 1 / 4);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, -size.height);

    canvas.drawPath(path, painter);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
