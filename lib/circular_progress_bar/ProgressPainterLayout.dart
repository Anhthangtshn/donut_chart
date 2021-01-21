import 'package:chart/circular_progress_bar/ProgressPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressLayout extends StatefulWidget {
  final double percent;

  const ProgressLayout({Key key, this.percent}) : super(key: key);

  @override
  _ProgressLayoutState createState() => _ProgressLayoutState();
}

class _ProgressLayoutState extends State<ProgressLayout> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Tween<double> _tween;
  AnimationController controller;
  double percent = 0.4;
  double end = 0.3;
  double begin = 0;

  void increase(value) {
    _tween.begin = _tween.end;
    begin = _tween.begin;
    controller.reset();
    end = (end + value).clamp(0.0, 1.0);
    _tween.end = end;
    controller.forward();
  }

  void decrease(value) {
    _tween.begin = _tween.end;
    controller.reset();
    begin = _tween.begin;
    begin = (begin - value).clamp(0.0, 1.0);
    _tween.end = begin;
    end = _tween.end;
    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    _tween = Tween<double>(begin: 0, end: 1 / 3);
    animation = _tween.animate(curve)
      ..addListener(() {
        setState(() {
          percent = animation.value;
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FlatButton(
                onPressed: () {
                  decrease(1 / 3);
                },
                child: Text('Decrease')),
            FlatButton(
                onPressed: () {
                  increase(1 / 3);
                },
                child: Text('Increase')),
          ],
        ),
        Container(
          width: double.infinity,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: CustomPaint(
            painter: ProgressPainter(percent),
          ),
        ),
      ],
    );
  }
}
