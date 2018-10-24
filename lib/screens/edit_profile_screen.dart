import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Profile"),
      ),
      body: new Center(
        child: new Card(
          margin: EdgeInsets.all(20.0),
          elevation: 5.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("data"),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("data"),
                width: double.infinity,
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
                        color: Colors.green,
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
