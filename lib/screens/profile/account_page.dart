import 'package:flutter/material.dart';

import 'package:userpet/screens/widgets/common_scaffold.dart';

class AccountPage extends StatefulWidget {
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
      appTitle: "Account",
      actionApp: false,
      bodyData: Center(child: Text("Account"),),
      elevation: 0.0,
    );
  }
}