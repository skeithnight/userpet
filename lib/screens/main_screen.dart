import 'package:flutter/material.dart';

import 'package:userpet/controllers/login_controller.dart';
import 'package:userpet/screens/dashboard/dashboard_one.page.dart';
import 'package:userpet/models/model/customer_model.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static String tag = 'main-page';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginController(context).checkToken();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        color: Colors.yellow,
        home: new FutureBuilder<Customer>(
          future: LoginController(context).checkSession(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return DashboardOnePage();
            } else if (snapshot.hasError) {
              // throw(snapshot.error);
              return new Center(
                  child: Container(
                height: 500.0,
                child: Text("${snapshot.error}"),
              ));
            }

            return new Center(child: CircularProgressIndicator());
          }),
        ));
  }
}
