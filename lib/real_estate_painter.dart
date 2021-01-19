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

  RealEstateChart(
    double animationValue, {
    final List<GradientColor> gradientColors,
    List<double> values,
    this.strokeWidth = 50,
  }) {
    _animationValue = animationValue;
    _total = values.fold(0, (v1, v2) => v1 + v2);
    for (int i = 0; i < values.length; i++) {
      Color firstColor = gradientColors[i].start;
      Color secondColor = gradientColors[i].end;
      final paint = new Paint()
        ..shader = RadialGradient(
          colors: [firstColor, secondColor],
        ).createShader(Rect.fromCircle(
          center: Offset(0, 0),
          radius: 100,
        ));
      paint.style = PaintingStyle.fill;
      _paintList.add(paint);
    }
    _values = values;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _values.length; i++) {
      final eachSectionAngle = _values[i] / _total * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2 + ((i % 2 == 0) ? 4 : -4)),
        _prevAngle,
        eachSectionAngle * _animationValue,
        true,
        _paintList[i]..strokeWidth = i * 20.0 * _animationValue,
      );
      _prevAngle += eachSectionAngle;
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
