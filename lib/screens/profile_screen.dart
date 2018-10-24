import 'package:flutter/material.dart';
import 'package:userpet/screens/login_screen.dart';
import './edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Profile"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: test(),
                  flex: 2,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: Text("Ubah"),
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
          new Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: new RaisedButton(
                    color: Colors.pink,
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ListTile test() {
  return ListTile(
    leading: new CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(Icons.people),
    ),
    title: Text("Nama"),
    subtitle: Text("email"),
    isThreeLine: true,
  );
}
