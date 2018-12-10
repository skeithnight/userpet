import 'package:flutter/material.dart';
import 'package:userpet/utils/uidata.dart';

import 'login_two_page.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: signUpBody(context),
      ),
    );
  }

  signUpBody(context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[signUpHeader(), signUpFields(context)],
        ),
      );

  signUpHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.green,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign Up",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  signUpFields(context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter your phone number",
                  labelText: "Phone Number",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LoginTwoPage())));
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => LoginTwoPage())));
              },
              child: Text(
                "Already have an account",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      );
}
