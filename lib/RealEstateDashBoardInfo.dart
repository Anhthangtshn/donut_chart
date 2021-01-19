import 'package:chart/RealEstateStatusItem.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class RealEstateDashBoardInfo extends StatefulWidget {
  const RealEstateDashBoardInfo({Key key}) : super(key: key);

  @override
  _RealEstateDashBoardInfoState createState() => _RealEstateDashBoardInfoState();
}

class _RealEstateDashBoardInfoState extends State<RealEstateDashBoardInfo> with SingleTickerProviderStateMixin {
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text("360", style: const TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w600, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 36.0)),
            SizedBox(
              width: 8,
            ),
            Text("quỹ hàng mới", style: const TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 12.0))
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: [
            RealEstateStatusItem(
              title: 'Chưa mở',
              color: Color(0xffc4c4c4),
              value: 25,
              animationValue: _animFraction,
            ),
            SizedBox(
              height: 8,
            ),
            RealEstateStatusItem(
              title: 'Trống',
              color: Color(0xff64c43b),
              value: 25,
              animationValue: _animFraction,
            ),
            SizedBox(
              height: 8,
            ),
            RealEstateStatusItem(
              title: 'Đặt cọc',
              color: Color(0xfff8c41c),
              value: 35,
              animationValue: _animFraction,
            ),
            SizedBox(
              height: 8,
            ),
            RealEstateStatusItem(
              title: 'Đặt chỗ',
              color: Color(0xff1e9ded),
              value: 15,
              animationValue: _animFraction,
            ),
            SizedBox(
              height: 8,
            ),
            RealEstateStatusItem(
              title: 'Đóng',
              color: Color(0xfff25c23),
              value: 30,
              animationValue: _animFraction,
            ),
          ],
        )
      ],
    );
  }
}