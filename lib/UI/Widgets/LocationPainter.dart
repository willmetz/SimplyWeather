import 'dart:math';

import 'package:flutter/material.dart';

class LocationPainter extends CustomPainter {
  final Color paintColor;
  final double xAsPercentWidth, yAsPercentHeight;
  Paint _paintBrush, _whiteBrush;

  LocationPainter(this.xAsPercentWidth, this.yAsPercentHeight, this.paintColor) {
    _paintBrush = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = paintColor;

    _whiteBrush = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double rectWidth = size.width * 0.2;
    double rectHeight = size.height * 0.5;

    double startAngle = 3.92699; //225 degrees
    double sweepAngle = 1.5708; //90 degrees

    Offset center = new Offset(size.width * xAsPercentWidth, size.height * yAsPercentHeight);

    Rect rect = new Rect.fromCenter(center: center, width: rectWidth, height: rectHeight);

    canvas.drawArc(rect, startAngle, sweepAngle, true, _paintBrush);

    Offset circleCenter = new Offset(size.width * xAsPercentWidth, size.height * yAsPercentHeight - rectHeight / 3);
    canvas.drawCircle(circleCenter, 3, _whiteBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
