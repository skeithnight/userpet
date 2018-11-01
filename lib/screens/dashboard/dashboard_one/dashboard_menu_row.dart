import 'package:flutter/material.dart';
import 'package:userpet/screens/widgets/label_below_icon.dart';

import 'package:userpet/screens/shopping/shopping_one_page.dart';

class DashboardMenuRow extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstIconCircleColor;
  final secondLabel;
  final IconData secondIcon;
  final secondIconCircleColor;
  final thirdLabel;
  final IconData thirdIcon;
  final thirdIconCircleColor;

  const DashboardMenuRow({
    Key key,
    this.firstLabel,
    this.firstIcon,
    this.firstIconCircleColor,
    this.secondLabel,
    this.secondIcon,
    this.secondIconCircleColor,
    this.thirdLabel,
    this.thirdIcon,
    this.thirdIconCircleColor,
  }) : super(key: key);

  void _clickMenu(){
    print("adadada");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: LabelBelowIcon(
              icon: firstIcon,
              label: firstLabel,
              circleColor: firstIconCircleColor,
              onPressed: _clickMenu,
            ),
          ),
          Expanded(
              child: LabelBelowIcon(
            icon: secondIcon,
            label: secondLabel,
            circleColor: secondIconCircleColor,
            onPressed: {},
          )),
          Expanded(
              child: LabelBelowIcon(
            icon: thirdIcon,
            label: thirdLabel,
            circleColor: thirdIconCircleColor,
            onPressed: () {},
          )),
        ],
      ),
    );
  }
}
