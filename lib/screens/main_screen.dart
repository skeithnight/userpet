import 'package:flutter/material.dart';
import 'package:userpet/screens/home_screen.dart' as home;
import 'package:userpet/screens/service_screen.dart' as service;
import 'package:userpet/screens/profile_screen.dart' as profile;

class MainScreen extends StatelessWidget {
  static String tag = 'main-page';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                new home.HomeScreen(),
                new service.ServiceScreen(),
                new profile.ProfileScreen(),
              ],
            ),
            bottomNavigationBar: TabBar(
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(icon: new Icon(Icons.home,color: Colors.black,),text: "Home",),
                Tab(icon: new Icon(Icons.pets,color: Colors.black,),text: "Service"),
                Tab(icon: new Icon(Icons.people,color: Colors.black,),text: "Profile"),
              ],
            )),
      ),
    );
  }
}
