import 'dart:math' as math;
import 'package:chart/pie_chart.dart';
import 'package:flutter/painting.dart';

import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  List<Paint> _paintList = [];
  List<double> _subParts;
  double _total = 0;
  double _totalAngle = math.pi * 2;
  double _angleFactor;

  final List<dynamic> contents;
  final double initialAngle;
  final int decimalPlaces;
  final bool showChartValueLabel;
  final ChartType chartType;
  final String centerText;
  final Function formatChartValues;
  final double strokeWidth;
  final Color emptyColor;

  double _prevAngle = 0;

  PieChartPainter(
    double angleFactor, {
    this.contents,
    List<double> values,
    List<String> titles,
    this.initialAngle,
    this.decimalPlaces,
    this.showChartValueLabel,
    this.chartType,
    this.centerText,
    this.formatChartValues,
    this.strokeWidth,
    this.emptyColor,
  }) {
    _angleFactor = angleFactor;
    _total = values.fold(0, (v1, v2) => v1 + v2);
    _totalAngle = angleFactor * math.pi * 2;
    for (int i = 0; i < values.length; i++) {
      Color firstColor;
      Color secondColor;
      switch (i) {
        case 0:
          firstColor = Color(0xfffce43c);
          secondColor = Color(0xfff8c41c);
          break;
        case 1:
          firstColor = Color(0xff40ccf7);
          secondColor = Color(0xff1e9ded);
          break;
        case 2:
          firstColor = Color(0xffa4ea72);
          secondColor = Color(0xff6ad13f);
          break;
        case 3:
          firstColor = Color(0xfffa9549);
          secondColor = Color(0xfff25c23);
          break;
      }
      final paint = new Paint()
        ..shader = RadialGradient(
          colors: [firstColor, secondColor],
        ).createShader(Rect.fromCircle(
          center: Offset(0, 0),
          radius: 100,
        ));
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = strokeWidth;
      _paintList.add(paint);
    }
    _subParts = values;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.width < size.height ? size.width : size.height;
    _prevAngle = this.initialAngle * math.pi / 180;
    for (int i = 0; i < _subParts.length; i++) {
      canvas.drawArc(
        new Rect.fromLTWH(0.0, 0.0, side, size.height),
        _prevAngle,
        ((_totalAngle / _total) * _subParts[i]) - math.pi * 5 / 180,
        chartType == ChartType.disc ? true : false,
        _paintList[i],
      );
      _prevAngle = _prevAngle + (((_totalAngle) / _total) * _subParts[i]);
    }
    _drawName(canvas, 0, 0, side);
  }

  void _drawName(Canvas canvas, double x, double y, double side) {
    TextSpan titleSpan = TextSpan(
      style: TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: side / 6),
      text: '${(contents[0] * _angleFactor).toStringAsFixed(0)}',
    );
    TextPainter tp = TextPainter(
      text: titleSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    TextSpan span1 = TextSpan(
      style: TextStyle(color: const Color(0xff6f84a4), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: side / 8),
      text: contents[1],
    );
    TextPainter tp1 = TextPainter(
      text: span1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp1.layout();
    tp.paint(
      canvas,
      new Offset(
        (side / 2 + x) - (tp.width / 2),
        (side / 2 + y) - (tp.height),
      ),
    );

    tp1.paint(
      canvas,
      new Offset(
        (side / 2 + x) - (tp1.width / 2),
        (side / 2 + y) + (tp1.height / 3),
      ),
    );
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => oldDelegate._totalAngle != _totalAngle;
}
