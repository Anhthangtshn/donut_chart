import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandPainter extends CustomPainter {
  double animFraction;

  DemandPainter(
    double angleFactor,
  ) {
    this.animFraction = angleFactor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawDashBackground(canvas, size);
  }

  _drawDashBackground(Canvas canvas, Size size) {
    final heightSpace = size.height / 6;

    for (int i = 0; i < 6; i++) {
      _drawDashLine(canvas, size, heightSpace * i);
    }
    _drawColumns(canvas, size, [
      'Bán',
      'Mua',
      'Cho Thuê',
      'Thuê',
      'SN',
      'Mua SN',
    ], [
      20,
      30,
      50,
      90,
      120,
      60
    ]);
  }

  _drawDashLine(Canvas canvas, Size size, double dy) {
    double dashWidth = 4, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = Color(0xffcccccc).withOpacity(0.3)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
      startX += dashWidth + dashSpace;
    }
  }

  _drawColumns(Canvas canvas, Size size, List<String> labels, List<int> values) {
    double columnWidth = 10.0;
    double spaceWidth = size.width / 12;
    double bottomColumnY = size.height / 6 * 5;
    int maxValue = values.reduce(max);
    for (int i = 0; i < 6; i++) {
      double centerX;
      if (i == 0) {
        centerX = spaceWidth;
      } else if (i == 5) {
        centerX = spaceWidth * 11;
      } else {
        centerX = (i * 2 + 1) * spaceWidth;
      }

      final paintHolder = Paint()..color = Color(0xff8099ec).withOpacity(0.1);
      double holderX1 = centerX + columnWidth / 2;
      double holderX2 = centerX - columnWidth / 2;
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(holderX1, bottomColumnY), Offset(holderX2, 0)), Radius.circular(3)), paintHolder);

      double percentWithMaxValue = values[i] / maxValue;
      double x1 = centerX + columnWidth / 2;
      double x2 = centerX - columnWidth / 2;
      double columnY = bottomColumnY * (0.2 + 0.8 * (1 - percentWithMaxValue)) + (1 - animFraction) * (bottomColumnY - bottomColumnY * (0.2 + 0.8 * (1 - percentWithMaxValue)));

      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color(0xff1555a7),
            const Color(0xff99b6ff),
          ],
        ).createShader(Rect.fromPoints(
          Offset(x1, 0),
          Offset(x1, size.height),
        ));
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(x1, bottomColumnY), Offset(x2, columnY)), Radius.circular(3)), paint);

      TextSpan titleSpan = TextSpan(
        style: TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 11.0),
        text: '${(values[i] * animFraction).toStringAsFixed(0)}',
      );
      TextPainter tp = TextPainter(
        text: titleSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp
        ..layout()
        ..paint(
          canvas,
          Offset(centerX - tp.size.width / 2, columnY - tp.size.height - 4),
        );

      TextSpan labelTextSpan = TextSpan(
        style: TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 10.0),
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
          Offset(centerX - labelTextPainter.size.width / 2, bottomColumnY + labelTextPainter.size.height /2 ),
        );
    }

    _drawBottomBackground(canvas,size);
  }

  _drawBottomBackground(Canvas canvas, Size size,){
    final paint = Paint()..color = Color(0xffd7e5ff).withOpacity(0.2);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(0, size.height / 6 * 5), Offset(size.width, size.height)), Radius.circular(3)), paint);
  }

  @override
  bool shouldRepaint(covariant DemandPainter oldDelegate) => oldDelegate.animFraction != animFraction;
}
