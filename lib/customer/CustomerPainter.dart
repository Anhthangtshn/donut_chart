import 'dart:math';

import 'package:chart/dash_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerPainter extends CustomPainter {
  double animFraction;
  List<int> values;
  List<double> percents = [];
  List<double> coordinatesY = [];
  List<double> coordinatesX = [];
  List<Offset> offsets = [];
  Animation<double> animation;
  static Offset currentPositionSelected;
  double dashAnimateValue;
  final labels = [
    '28',
    '29',
    '30',
    '31',
    '01',
    '02',
    '03',
  ];
  int rowNumber;

  CustomerPainter(double animFraction, double dashAnimateValue, {int values, Animation<double> animation}) : super(repaint: animation) {
    this.animFraction = animFraction;
    this.dashAnimateValue = dashAnimateValue;
    this.values = values ?? [20, 40, 80, 90, 200, 60, 80];
    this.animation = animation;
    rowNumber = this.values.length;
  }

  double maxHeightCanDraw;
  double heightUnit;

  @override
  void paint(Canvas canvas, Size size) {
    coordinatesX.clear();
    coordinatesY.clear();
    percents.clear();
    offsets.clear();
    heightUnit = size.height / rowNumber;
    maxHeightCanDraw = size.height - heightUnit;
    _drawDashBackground(canvas, size);
    _calculateCoordinatePoints();
    _drawDashLine(canvas, size);
    _drawPoint(canvas, size);
    _fillColor(canvas, size);
    if (dashAnimateValue == 1) _drawPulse(canvas);
    if (dashAnimateValue == 1) _drawValue(canvas);
    if (dashAnimateValue == 1) _drawCurrentSelectedPoint(canvas);
  }

  _drawCurrentSelectedPoint(Canvas canvas) {
    final paint = Paint()
      ..color = Color(0xff326fe3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(currentPositionSelected, 4, paint);
  }

  _drawPulse(Canvas canvas) {
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, wave + animation.value);
    }
  }

  void circle(Canvas canvas, double value) {
    double opacity = (1.0 - (value / 2)).clamp(0.0, 0.6);
    Color color = Color(0xff1f6df4).withOpacity(opacity);
    double size = 20;
    double area = size * size;
    double radius = sqrt(area * value / 4);
    final paint = Paint()..color = color;
    canvas.drawCircle(currentPositionSelected, radius, paint);
  }

  _drawValue(
    Canvas canvas,
  ) {
    int index = offsets.indexOf(currentPositionSelected);
    TextSpan labelTextSpan = TextSpan(
      style: TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 11.0),
      text: '${values[index]}',
    );
    TextPainter labelTextPainter = TextPainter(
      text: labelTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    labelTextPainter
      ..layout()
      ..paint(
        canvas,
        Offset(currentPositionSelected.dx - labelTextPainter.size.width / 2, currentPositionSelected.dy - labelTextPainter.size.height * 2),
      );
  }

  _fillColor(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          const Color(0x4bdef3ff),
          const Color(0xa96fc3f7),
        ],
      ).createShader(Rect.fromPoints(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, maxHeightCanDraw),
      ));
    List<Offset> tempList = offsets.map((e) => Offset(e.dx, maxHeightCanDraw - (maxHeightCanDraw - e.dy) * animFraction)).toList();
    List<Offset> listPolygonOffset = [];
    listPolygonOffset
      ..add(Offset(0, maxHeightCanDraw))
      ..add(Offset(0, maxHeightCanDraw - 10))
      ..addAll(tempList)
      ..add(Offset(offsets[offsets.length - 1].dx, maxHeightCanDraw));
    final path = Path()..addPolygon(listPolygonOffset, false);
    canvas.drawPath(path, paint);
  }

  _drawDashBackground(Canvas canvas, Size size) {
    _drawDashVerticalLine(canvas, size);
    _drawDashHorizontalLine(canvas, size);
    _drawBottomBackground(canvas, size);
  }

  _drawDashLine(Canvas canvas, Size size) {
    if (dashAnimateValue > 0.0) {
      final paint = Paint()
        ..color = Color(0xff007bff)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      final path = Path()..moveTo(0, maxHeightCanDraw - 10);
      for (int i = 0; i < values.length; i++) {
        path
          ..lineTo(
            offsets[i].dx,
            offsets[i].dy,
          );
      }
      canvas.drawPath(dashPath(path, animationValue: dashAnimateValue, dashArray: CircularIntervalList<double>(<double>[3, 3])), paint);
    }
  }

  _drawPoint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff566da0)
      ..style = PaintingStyle.fill;

    final paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final mainCircleCenter = Offset(offsets[i].dx, maxHeightCanDraw - (maxHeightCanDraw - offsets[i].dy) * animFraction);
      canvas.drawCircle(mainCircleCenter, 3, paint);
      canvas.drawCircle(mainCircleCenter, 2, paint1);
    }
  }

  _drawDashHorizontalLine(
    Canvas canvas,
    Size size,
  ) {
    for (int i = 0; i < rowNumber; i += 2) {
      final paint = Paint()
        ..color = Color(0xffcccccc).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      final path = Path()
        ..moveTo(0, heightUnit * i)
        ..lineTo(size.width, heightUnit * i);
      canvas.drawPath(dashPath(path, dashArray: CircularIntervalList<double>(<double>[3, 3])), paint);
    }
  }

  _drawDashVerticalLine(Canvas canvas, Size size) {
    double spaceWidth = size.width / (rowNumber * 2);
    double bottomColumnY = size.height / rowNumber * (rowNumber - 1);
    for (int i = 0; i < rowNumber; i++) {
      double centerX;
      if (i == 0) {
        centerX = spaceWidth;
      } else {
        centerX = (i * 2 + 1) * spaceWidth;
      }

      coordinatesX.add(centerX);

      final paint = Paint()
        ..color = Color(0xffcccccc).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      final path = Path()
        ..moveTo(centerX, -15)
        ..lineTo(centerX, maxHeightCanDraw);
      canvas.drawPath(dashPath(path, dashArray: CircularIntervalList<double>(<double>[3, 3])), paint);

      TextSpan labelTextSpan = TextSpan(
        style: TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 12),
        text: '${labels[i]}',
      );
      TextPainter labelTextPainter = TextPainter(
        text: labelTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      labelTextPainter
        ..layout()
        ..paint(
          canvas,
          Offset(centerX - labelTextPainter.size.width / 2, bottomColumnY + labelTextPainter.size.height / 3),
        );
    }
  }

  _drawBottomBackground(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()..color = Color(0xffd7e5ff).withOpacity(0.2);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(0, maxHeightCanDraw), Offset(size.width, size.height)), Radius.circular(3)), paint);
  }

  _calculateCoordinatePoints() {
    int maxValue = values.reduce(max);
    percents.clear();
    values.forEach((element) {
      percents.add(element.toDouble() / maxValue.toDouble());
    });
    percents.forEach((element) {
      coordinatesY.add(0 + maxHeightCanDraw * (1 - element));
    });
    for (int i = 0; i < values.length; i++) {
      offsets.add(Offset(coordinatesX[i], coordinatesY[i]));
    }
    if (currentPositionSelected == null) currentPositionSelected = offsets[4];
  }

  _drawDashLineFromPoints(List<int> values, Canvas canvas) {}

  @override
  bool shouldRepaint(covariant CustomerPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    for (int i = 0; i < offsets.length; i++) {
      final Path path = new Path();
      path.addRect(Rect.fromPoints(Offset(offsets[i].dx - 10, offsets[i].dy - 20), Offset(offsets[i].dx + 10, maxHeightCanDraw + heightUnit)));
      if (path.contains(position)) {
        currentPositionSelected = offsets[i];
        return true;
      }
    }
    return false;
  }
}
