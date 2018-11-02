import 'package:flutter/material.dart';
import 'package:userpet/screens/dashboard/dashboard_one.page.dart';

class MainScreen extends StatelessWidget {
  static String tag = 'main-page';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DashboardOnePage()
    );
  }
}
