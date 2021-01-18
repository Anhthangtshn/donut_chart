import 'package:flutter/material.dart';
import 'chart_painter.dart';

enum LegendPosition { top, bottom, left, right }

enum ChartType { disc, ring }

class PieChart extends StatefulWidget {
  PieChart({
    @required this.dataMap,
    this.chartType = ChartType.disc,
    this.chartRadius,
    this.animationDuration,
    this.chartLegendSpacing = 48,
    this.initialAngleInDegree = 0.0,
    this.formatChartValues,
    this.centerText,
    this.ringStrokeWidth = 20.0,
    this.emptyColor = Colors.grey,
    Key key,
    this.contents,
  }) : super(key: key);

  final Map<String, double> dataMap;
  final ChartType chartType;
  final double chartRadius;
  final Duration animationDuration;
  final double chartLegendSpacing;
  final double initialAngleInDegree;
  final Function formatChartValues;
  final String centerText;
  final double ringStrokeWidth;
  final Color emptyColor;
  final List<dynamic> contents;

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double _animFraction = 0.0;

  List<String> legendTitles;
  List<double> legendValues;

  void initLegends() {
    this.legendTitles = widget.dataMap.keys.toList(growable: false);
  }

  void initValues() {
    this.legendValues = widget.dataMap.values.toList(growable: false);
  }

  void initData() {
    assert(
      widget.dataMap != null && widget.dataMap.isNotEmpty,
      "dataMap passed to pie chart cant be null or empty",
    );
    initLegends();
    initValues();
  }

  @override
  void initState() {
    super.initState();
    initData();
    controller = AnimationController(
      duration: widget.animationDuration ?? Duration(milliseconds: 800),
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

  Widget _getChart() {
    return LayoutBuilder(
      builder: (_, c) => CustomPaint(
        painter: PieChartPainter(
          _animFraction,
          contents: widget.contents,
          values: legendValues,
          titles: legendTitles,
          initialAngle: widget.initialAngleInDegree,
          chartType: widget.chartType,
          centerText: widget.centerText,
          formatChartValues: widget.formatChartValues,
          strokeWidth: widget.ringStrokeWidth,
          emptyColor: widget.emptyColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.chartRadius,
      width: widget.chartRadius,
      padding: EdgeInsets.all(8.0),
      child: _getChart(),
    );
  }

  @override
  void didUpdateWidget(PieChart oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
