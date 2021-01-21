import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientColor {
  final Color start;
  final Color end;

  GradientColor(this.start, this.end);
}

class RealEstateChart extends CustomPainter {
  List<Paint> _paintList = [];
  List<double> _values;
  double _total = 0;
  final double strokeWidth;
  double _prevAngle = 270 / 360 * 2 * math.pi;
  double _animationValue;
  List<GradientColor> gradientColors;

  RealEstateChart(
    double animationValue, {
    final List<GradientColor> gradientColors,
    List<double> values,
    this.strokeWidth = 50,
  }) {
    _animationValue = animationValue;
    _total = values.fold(0, (v1, v2) => v1 + v2);
    this.gradientColors = gradientColors;
    for (int i = 0; i < values.length; i++) {
      final paint = new Paint();
      _paintList.add(paint);
    }
    _values = values;
  }

  List<double> angles = [];
  List<double> listRadius = [];

  @override
  void paint(Canvas canvas, Size size) {
    List<double> percentHeight = [1, 94 / 80, 84 / 80, 94 / 80, 88 / 80];
    _prevAngle = 1.5 * math.pi;
    angles.clear();
    listRadius.clear();
    for (int i = 0; i < _values.length; i++) {
      final eachSectionAngle = _values[i] / _total * 2 * math.pi;
      final radius = size.width / 2 * percentHeight[i];
      listRadius.add(radius);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        _prevAngle,
        eachSectionAngle * _animationValue,
        true,
        _paintList[i]
          ..shader = RadialGradient(
            colors: [gradientColors[i].start, gradientColors[i].end],
          ).createShader(Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2,
          )),
      );
      angles.add(_prevAngle);
      _prevAngle += eachSectionAngle;
    }

    for (int i = 0; i < angles.length; i++) {
      final angle = 0.5 * math.pi - (angles[i] - 1.5 * math.pi);
      final x = size.width / 2;
      final y = size.width / 2;
      final radius = listRadius[i] + 10;
      final x1 = x + radius * math.cos(angle);
      final y1 = y - radius * math.sin(angle);
      canvas.drawLine(
          Offset(size.width / 2, size.height / 2),
          Offset(x1, y1),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width * _animationValue / 3.5,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.black.withOpacity(0.2));

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * _animationValue / 8,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(RealEstateChart oldDelegate) => oldDelegate._animationValue != _animationValue;
}
