import 'package:flutter/material.dart';

class RadarLegend extends StatelessWidget {
  final String _label;
  final List<LegendColor> _colors;
  final double _height;

  RadarLegend(this._label, this._colors, this._height);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _colors.map((e) => e.color).toList(), stops: _colors.map((e) => e.stop.toDouble()).toList())),
        ),
        Align(child: Text(_label))
      ],
    );
  }
}

class LegendColor {
  final Color color;
  final num stop;

  LegendColor(this.color, this.stop);
}
