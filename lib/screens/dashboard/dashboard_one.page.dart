import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userpet/screens/dashboard/dashboard_one/dashboard_menu_row.dart';
import 'package:userpet/screens/widgets/login_background.dart';
import 'package:userpet/screens/widgets/profile_tile.dart';
import 'package:userpet/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:userpet/screens/login/login_two_page.dart';
import 'package:userpet/models/model/customer_model.dart';
import 'package:userpet/screens/order/list_order_page.dart';

class DashboardOnePage extends StatefulWidget {
  Customer customer = new Customer();
  DashboardOnePage(this.customer);
  _DashboardOnePageState createState() => _DashboardOnePageState();
}

class _DashboardOnePageState extends State<DashboardOnePage> {
  Size deviceSize;
  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  new ProfileTile(
                    title:
                        "Hi, ${widget.customer.name.split(" ")[0].toUpperCase()}",
                    subtitle: "Welcome to Sahi Pet",
                    textColor: Colors.white,
                  ),
                  new Row(
                    children: <Widget>[
                      new IconButton(
                        icon: Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                        onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ListOrderPage())));},
                      ),
                      new PopupMenuButton(
                          icon: Icon(Icons.more, color: Colors.white),
                          elevation: 5.0,
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                                new PopupMenuItem<String>(
                                    child: const Text('Profile'),
                                    value: 'profile'),
                                new PopupMenuItem<String>(
                                    child: const Text('Logout'),
                                    value: 'logout'),
                              ],
                          onSelected: (value) {
                            if (value == 'logout') {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginTwoPage())));
                            }
                          }),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget searchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Find our product"),
                  ),
                ),
                Icon(Icons.menu),
              ],
            ),
          ),
        ),
      );

  Widget actionMenuCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DashboardMenuRow(
                    firstIcon: FontAwesomeIcons.images,
                    firstLabel: "Hotel",
                    firstIconCircleColor: Colors.red,
                    firstValueRoute: "Hotel",
                    secondIcon: FontAwesomeIcons.solidHeart,
                    secondLabel: "Klinik",
                    secondIconCircleColor: Colors.teal,
                    secondValueRoute: "Klinik",
                    thirdIcon: FontAwesomeIcons.solidNewspaper,
                    thirdLabel: "Grooming",
                    thirdIconCircleColor: Colors.lime,
                    thirdValueRoute: "Grooming",
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget balanceCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Balance",
                      style: TextStyle(fontFamily: UIData.ralewayFont),
                    ),
                    Material(
                      color: Colors.black,
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "500 Points",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: UIData.ralewayFont),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "₹ 1000",
                  style: TextStyle(
                      fontFamily: UIData.ralewayFont,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                      fontSize: 25.0),
                ),
              ],
            ),
          ),
        ),
      );

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            searchCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
            actionMenuCard(),
            SizedBox(
              height: deviceSize.height * 0.01,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }
}
