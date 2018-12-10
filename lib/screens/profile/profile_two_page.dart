import 'package:flutter/material.dart';
import 'package:userpet/screens/widgets/common_scaffold.dart';
import 'package:userpet/utils/uidata.dart';

import 'package:userpet/screens/profile/account_page.dart';
import 'package:userpet/screens/profile/pets_page.dart';
import 'package:userpet/screens/login/login_two_page.dart';

class ProfileTwoPage extends StatelessWidget {
  Size deviceSize;

  Widget profileHeader() => Container(
        height: deviceSize.height / 4,
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.black,
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                          "http://www.nationalarchives.gov.uk/wp-content/uploads/2016/01/John-Sheridan1.jpg"),
                    ),
                  ),
                  Text(
                    "John Sheridan",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Text(
                    "johnsheridan@gmail.com",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  Widget imagesCard() => Container(
        height: deviceSize.height / 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Photos",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "https://cdn.pixabay.com/photo/2016/10/31/18/14/ice-1786311_960_720.jpg"),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget descCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Identity",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "email",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );
  Widget bodyData(context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileHeader(),
            bodyData2(context),
            // postCard(),
          ],
        ),
      );

  Widget bodyData2(context) => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "General",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountPage()));
                      },
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: Text("Account"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PetsPage()));
                      },
                      leading: Icon(
                        Icons.pets,
                        color: Colors.red,
                      ),
                      title: Text("Pets"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ),

              //Logout
              Container(
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginTwoPage())));
                  },
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text("Logout"),
                  elevation: 2.0,
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
      appTitle: "Profile",
      actionApp: false,
      bodyData: bodyData(context),
      elevation: 0.0,
    );
  }
}
