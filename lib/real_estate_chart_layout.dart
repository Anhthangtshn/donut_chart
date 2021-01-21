import 'package:chart/real_estate_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RealEstateChartLayout extends StatefulWidget {
  const RealEstateChartLayout({Key key}) : super(key: key);

  @override
  _RealEstateChartLayoutState createState() => _RealEstateChartLayoutState();
}

class _RealEstateChartLayoutState extends State<RealEstateChartLayout> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double _animFraction = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 800),
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: CustomPaint(
        child: SizedBox(),
        painter: RealEstateChart(
          _animFraction,
          values: [10, 30, 50, 100,60],
          gradientColors: [GradientColor(Color(0xffd1d1d1), Color(0xffe3e3e3)),GradientColor(Color(0xff9de46d), Color(0xff64c43b)),GradientColor(Color(0xffffe42a), Color(0xfff6bd00)),GradientColor(Color(0xff3fd2ff), Color(0xff0a94ec)),GradientColor(Color(0xffffa920), Color(0xffec4a00)),  ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
