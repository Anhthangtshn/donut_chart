import 'package:chart/DemandPainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class DemandLayout extends StatefulWidget {
  const DemandLayout({Key key,}) : super(key: key);
  @override
  _DemandLayoutState createState() => _DemandLayoutState();
}

class _DemandLayoutState extends State<DemandLayout> with SingleTickerProviderStateMixin {
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
      curve: Curves.ease,
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
                Text("Nhu cầu - T9/2020", style: const TextStyle(color: const Color(0xff326fe3), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 16.0)),
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
                painter: DemandPainter(_animFraction),
              ),
            ),
          )
        ],
      ),
    );
  }
}
