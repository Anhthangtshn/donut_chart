import 'package:flutter/widgets.dart';

class RealEstateStatusItem extends StatelessWidget {
  final String title;
  final Color color;
  final int value;
  final double animationValue;

  const RealEstateStatusItem({Key key, this.title, this.color, this.value, this.animationValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(width: 12, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: color)),
              SizedBox(
                width: 8,
              ),
              Text(title, style: const TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w400, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 12.0))
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(width: 4, height: 4, decoration: BoxDecoration(color: Color(0xff6e8db2))),
              SizedBox(
                width: 8,
              ),
              Text('${(value * animationValue).toStringAsFixed(0)}%', style: const TextStyle(color: const Color(0xff48668a), fontWeight: FontWeight.w500, fontFamily: "SFProText", fontStyle: FontStyle.normal, fontSize: 12.0))
            ],
          ),
        )
      ],
    );
  }
}