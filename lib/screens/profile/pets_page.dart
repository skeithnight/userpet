import 'package:flutter/material.dart';

import 'package:userpet/screens/widgets/common_scaffold.dart';

class PetsPage extends StatefulWidget {
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
      appTitle: "Pets",
      actionApp: false,
      bodyData: Center(child: Text("Pets"),),
      elevation: 0.0,
    );
  }
}