import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressPainter extends CustomPainter {
  final double percent;

  ProgressPainter(this.percent);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBgLine(canvas, size);
    final firstPoint = Offset(0, size.height / 2);
    final lastPoint = Offset(size.width * percent, size.height / 2);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xffa2bfff), Color(0xff1a2bab)],
      ).createShader(Rect.fromPoints(firstPoint, lastPoint))
      ..strokeWidth = 6;
    canvas.drawLine(firstPoint, lastPoint, paint);
    drawCirclePoint(canvas, lastPoint);
  }

  drawCirclePoint(Canvas canvas, Offset offset) {
    final bgPaint = Paint()
      ..color = Colors.white
      ..shader = RadialGradient(
        colors: [Color(0xd81e219e), Color(0x1975a8f9)],
      ).createShader(Rect.fromCircle(center: offset, radius: 12))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, 16, bgPaint);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, 6, paint);
  }

  _drawBgLine(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xffe0e0e0)
      ..strokeWidth = 6;
    final firstPoint = Offset(0, size.height / 2);
    final lastPoint = Offset(size.width, size.height / 2);
    canvas.drawLine(firstPoint, lastPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
