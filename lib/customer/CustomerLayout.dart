import 'package:chart/DemandPainter.dart';
import 'package:flutter/widgets.dart';

import 'CustomerPainter.dart';

class CustomerLayout extends StatefulWidget {
  CustomerLayout({
    Key key,
  }) : super(key: key);

  @override
  _CustomerLayoutState createState() => _CustomerLayoutState();
}

class _CustomerLayoutState extends State<CustomerLayout> with TickerProviderStateMixin {
  AnimationController pulseController;
  Animation<double> polygonAnimation;
  AnimationController polygonController;
  double polygonValue = 0.0;

  Animation<double> dashAnimation;
  AnimationController dashController;
  double dashAnimateValue = 0.0;

  @override
  void initState() {
    super.initState();
    polygonController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: polygonController,
      curve: Curves.ease,
    );
    polygonAnimation = Tween<double>(begin: 0, end: 1).animate(curve)
      ..addListener(() {
        setState(() {
          polygonValue = polygonAnimation.value;
        });
      });
    polygonController.forward();

    polygonController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        print('polygonController =======$polygonController');
        dashController.forward();
      }
    });

    pulseController = new AnimationController(
      vsync: this,
    );
    _startAnimation();

    dashController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    final Animation dashCurve = CurvedAnimation(
      parent: dashController,
      curve: Curves.ease,
    );
    dashAnimation = Tween<double>(begin: 0, end: 1).animate(dashCurve)
      ..addListener(() {
        setState(() {
          dashAnimateValue = dashAnimation.value;
        });
      });
  }

  void _startAnimation() {
    pulseController.stop();
    pulseController.reset();
    pulseController.repeat(
      period: Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    pulseController?.dispose();
    polygonController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [BoxShadow(color: const Color(0x33000000), offset: Offset(1, 1), blurRadius: 7, spreadRadius: 0)], color: const Color(0xffffffff)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Khách hàng - T9/2020", style: const TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 16.0)),
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
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: CustomPaint(
                painter: CustomerPainter(polygonValue,dashAnimateValue, animation: pulseController),
              ),
            ),
          )
        ],
      ),
    );
  }
}
