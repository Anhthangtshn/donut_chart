import 'package:flutter/widgets.dart';

import 'main.dart';

class WorkBarChar extends StatefulWidget {
  const WorkBarChar({Key key}) : super(key: key);

  @override
  _WorkBarCharState createState() => _WorkBarCharState();
}

class _WorkBarCharState extends State<WorkBarChar> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double _animFraction = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(curve)
      ..addListener(() {
        setState(() {
          _animFraction = animation.value;
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
        Container(
          height: 40,
          child: CustomPaint(
            painter: ProgressBarPainter(Color(0xfff25c23), 0.3, title: 'Quá hạn', value: 05, animFraction: _animFraction),
            child: Container(),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 40,
          child: CustomPaint(
            painter: ProgressBarPainter(Color(0xfff8c41c), 0.6, title: 'Chưa xử lý', value: 20, animFraction: _animFraction),
            child: Container(),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 40,
          child: CustomPaint(
            painter: ProgressBarPainter(Color(0xff1e9ded), 0.3, title: 'Đang xử lý', value: 15, animFraction: _animFraction),
            child: Container(),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 40,
          child: CustomPaint(
            painter: ProgressBarPainter(Color(0xff64c43b), 0.4, title: 'Hoàn thành', value: 70, animFraction: _animFraction),
            child: Container(),
          ),
        ),
      ],
    );
  }
}