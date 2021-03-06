import 'dart:io';
import 'dart:math' as math;
import 'dart:math';

import 'package:chart/DemandLayout.dart';
import 'package:chart/pie_chart.dart';
import 'package:chart/real_estate_chart_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'RealEstateDashBoardInfo.dart';
import 'WorkBarChar.dart';
import 'customer/CustomerLayout.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  enablePlatformOverrideForDesktop();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pie Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

enum LegendShape { Circle, Rectangle }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> dataMap = {
    "Flutter": 2,
    "React": 3,
    "Xamarin": 1,
    "Ionic": 5,
  };

  ChartType _chartType = ChartType.ring;
  double _ringStrokeWidth = 14;
  double _chartLegendSpacing = 32;
  int key = 0;

  bool a = true, b = true, c = true, d = true;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      contents: [36, 'Thanh Hóa'],
      animationDuration: Duration(milliseconds: 1200),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: 130,
      initialAngleInDegree: 270,
      chartType: _chartType,
      // centerText: _showCenterText ? "HYBRID" : null,
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: Colors.grey,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Huy Thanh Hóa Ăn Rau Má"),
          actions: [
            FlatButton(
              onPressed: () {
                setState(() {
                  key = key + 1;
                });
              },
              child: Text("Reload".toUpperCase()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(
                  children: [
                    CheckBoxItem(
                      value: a,
                      title: 'Công việc',
                      callback: (value) {
                        setState(() {
                          a = value;
                        });
                      },
                    ),
                    CheckBoxItem(
                      value: b,
                      title: 'Khách hàng',
                      callback: (value) {
                        setState(() {
                          b = value;
                        });
                      },
                    ),
                    CheckBoxItem(
                      value: c,
                      title: 'Quỹ hàng',
                      callback: (value) {
                        setState(() {
                          c = value;
                        });
                      },
                    ),
                    CheckBoxItem(
                      value: d,
                      title: 'Nhu cầu',
                      callback: (value) {
                        setState(() {
                          d = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (a)
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [BoxShadow(color: const Color(0x33000000), offset: Offset(1, 1), blurRadius: 7, spreadRadius: 0)], color: const Color(0xffffffff)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Công việc - T9/2020", style: const TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 16.0)),
                          Text("Xem chi tiết",
                              style: const TextStyle(
                                color: const Color(0xff196dff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProText",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0,
                                decoration: TextDecoration.underline,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [WorkBarChar(key: ValueKey(key))],
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(child: chart),
                        ],
                      ),
                    ],
                  ),
                ),
              if (b)
                CustomerLayout(
                  key: ValueKey(key + 30000),
                ),
              if (c)
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [BoxShadow(color: const Color(0x33000000), offset: Offset(1, 1), blurRadius: 7, spreadRadius: 0)], color: const Color(0xffffffff)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quỹ hàng - T9/2020", style: const TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 16.0)),
                          Text("Xem chi tiết",
                              style: const TextStyle(
                                color: const Color(0xff196dff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProText",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0,
                                decoration: TextDecoration.underline,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: RealEstateDashBoardInfo(
                                key: ValueKey(key),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: RealEstateChartLayout(
                                  key: ValueKey(key),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (d)
                DemandLayout(
                  key: ValueKey(key),
                ),
            ],
          ),
        ));
  }
}

class CheckBoxItem extends StatelessWidget {
  final bool value;
  final String title;
  final Function(bool) callback;

  const CheckBoxItem({Key key, this.value, this.callback, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: callback,
        ),
        Text(
          title,
          style: TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 8),
        )
      ],
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double animFraction;
  final Color color;
  final double percent;
  final String title;
  final int value;

  ProgressBarPainter(
    this.color,
    this.percent, {
    @required this.title,
    @required this.value,
    this.animFraction,
  });

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final height = 8;
    final lineRadius = Radius.circular(1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height - height),
          Offset(size.width, size.height),
        ),
        lineRadius,
      ),
      Paint()..color = Color(0xffe7effa),
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromPoints(
          Offset(0.0, size.height - height),
          Offset(size.width * percent * animFraction, size.height),
        ),
        topLeft: Radius.circular(2),
        bottomLeft: Radius.circular(2),
        topRight: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      Paint()..color = color,
    );
    final fontSize = size.width / 14;
    _drawName(canvas, title, Point(0.0, 0.0), fontSize: fontSize);
    _drawName(canvas, '${(value * animFraction).toStringAsFixed(0)}', Point(size.width, 0.0), rightPosition: true, fontSize: fontSize);
  }

  void _drawName(Canvas canvas, String name, Point point, {bool rightPosition = false, double fontSize = 20}) {
    TextSpan titleSpan = TextSpan(
      style: TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: fontSize),
      text: name,
    );
    TextPainter tp = TextPainter(
      text: titleSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      new Offset(point.x - (rightPosition ? tp.width : 0), point.y),
    );
  }
}
