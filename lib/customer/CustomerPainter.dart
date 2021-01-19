import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerPainter extends CustomPainter {
  double animFraction;

  CustomerPainter(
    double angleFactor,
  ) {
    this.animFraction = angleFactor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawDashBackground(canvas, size);
  }

  _drawDashBackground(Canvas canvas, Size size) {
    final heightSpace = size.height / 7;
    for (int i = 0; i < 7; i += 2) {
      _drawDashRow(canvas, size, heightSpace * i);
    }
    _drawDashColumns(canvas, size, [
      '28',
      '29',
      '30',
      '31',
      '01',
      '02',
      '03',
    ], [
      20,
      30,
      50,
      90,
      120,
      60
    ]);
    _drawBottomBackground(canvas, size);
  }

  _drawDashRow(Canvas canvas, Size size, double dy) {
    double dashWidth = 4, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = Color(0xffcccccc).withOpacity(0.3)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
      startX += dashWidth + dashSpace;
    }
  }

  _drawDashColumns(Canvas canvas, Size size, List<String> labels, List<int> values) {
    double spaceWidth = size.width / 14;
    double bottomColumnY = size.height / 7 * 6;
    for (int i = 0; i < 7; i++) {
      double centerX;
      if (i == 0) {
        centerX = spaceWidth;
      } else {
        centerX = (i * 2 + 1) * spaceWidth;
      }
      double dashWidth = 4, dashSpace = 3, startY = -10;
      final paint = Paint()
        ..color = Color(0xffcccccc).withOpacity(0.3)
        ..strokeWidth = 1;
      while (startY < size.height / 8 * 7 - dashWidth) {
        canvas.drawLine(Offset(centerX, startY), Offset(centerX, startY + dashWidth), paint);
        startY += dashWidth + dashSpace;
      }
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
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(0, size.height / 7 * 6), Offset(size.width, size.height)), Radius.circular(3)), paint);
  }

  _drawDashLineFromPoints(Offset start, Offset end, Canvas canvas) {
    // double dashWidth = 4, dashSpace = 3, startX = start.dx;
    // final paint = Paint()
    //   ..color = Color(0xffcccccc).withOpacity(0.3)
    //   ..strokeWidth = 1;
    // while (startX < end.dx) {
    //   canvas.drawLine(Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
    //   startX += dashWidth + dashSpace;
    // }
  }

  @override
  bool shouldRepaint(covariant CustomerPainter oldDelegate) => oldDelegate.animFraction != animFraction;
}
