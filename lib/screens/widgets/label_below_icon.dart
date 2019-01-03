import 'package:flutter/material.dart';
import 'package:userpet/utils/uidata.dart';
import 'package:userpet/screens/shopping/store_page.dart';

class LabelBelowIcon extends StatelessWidget {
  final label;
  final IconData icon;
  final iconColor;
  final valueRoute;
  final circleColor;
  final isCircleEnabled;
  final betweenHeight;

  LabelBelowIcon(
      {this.label,
      this.icon,
      this.valueRoute,
      this.iconColor = Colors.white,
      this.circleColor,
      this.isCircleEnabled = true,
      this.betweenHeight = 5.0});

  routing(context, valueRoute) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => StorePage(valueRoute)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => routing(context, valueRoute),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isCircleEnabled
              ? CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 20.0,
                  child: Icon(
                    icon,
                    size: 12.0,
                    color: iconColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 23.0,
                  color: iconColor,
                ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: UIData.ralewayFont),
          )
        ],
      ),
    );
  }
}
