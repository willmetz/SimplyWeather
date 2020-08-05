import 'package:flutter/material.dart';

class LocationPainter extends CustomPainter {
  final Color paintColor;
  final double xAsPercentWidth, yAsPercentHeight;
  Paint _paintBrush;

  LocationPainter(this.xAsPercentWidth, this.yAsPercentHeight, this.paintColor) {
    _paintBrush = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = paintColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width * xAsPercentWidth, size.height * yAsPercentHeight);

    canvas.drawCircle(center, 5, _paintBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
