import 'package:flutter/material.dart';
import 'package:userpet/utils/uidata.dart';

import 'package:userpet/models/model/customer_model.dart';
import 'login_two_page.dart';
import 'package:userpet/controllers/register_controller.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Customer customer = new Customer();
  Size deviceSize;

  bool isloading = false;
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
                onChanged: (text) {
                  setState(() {
                    this.customer.name = text;
                  });
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    this.customer.username = text;
                  });
                },
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
                onChanged: (text) {
                  setState(() {
                    this.customer.password = text;
                  });
                },
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: isloading == false
                  ? RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      shape: StadiumBorder(),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          this.isloading = true;
                        });
                        RegisterController(context).sendData(customer);
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
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
