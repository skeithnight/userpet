import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:userpet/inherited/product_provider.dart';
import 'package:userpet/logic/bloc/product_bloc.dart';
import 'package:userpet/models/product.dart';
import 'package:userpet/screens/shopping/shopping_details/shopping_widget.dart';
import 'package:userpet/screens/widgets/common_scaffold.dart';
import 'package:userpet/screens/widgets/login_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_places_picker/google_places_picker.dart';

import 'package:userpet/models/model/petshop_model.dart';
import 'package:userpet/models/model/order_model.dart';
import 'package:userpet/controllers/petshop_controller.dart';
import 'package:userpet/controllers/product_controller.dart';
import 'package:userpet/models/model/service_model.dart';
import 'package:userpet/models/model/detail_transaksi_model.dart';
import 'package:userpet/screens/main_screen.dart';

class OrderPage extends StatefulWidget {
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Size deviceSize;
  BuildContext mcontext;
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final formatCurrency = new NumberFormat.simpleCurrency(name: "IDR");

  List<Petshop> listPetshop = new List();
  Order order = new Order();
  String idPetshop;
  Place _place;
  List<DetailTransaksi> listGroomings = new List();
  List<DetailTransaksi> listClinics = new List();
  List<DetailTransaksi> listHotels = new List();

  var txt = new TextEditingController();

  bool isLoading = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  _showPlacePicker() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    Place place = await PluginGooglePlacePicker.showPlacePicker();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _place = place;
      order.latitude = place.latitude;
      order.longitude = place.longitude;
      order.address = place.address;
      txt.text = place.address;
    });
  }

  Widget locationCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Lokasi Antar Jemput",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      "Pick Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      try {
                        _showPlacePicker();
                      } catch (e) {
                        tampilDialog("Alert", "Failed to load location");
                      }
                    },
                  ),
                ),
                // new TextField(
                //   keyboardType: TextInputType.number,
                //   autofocus: true,
                //   decoration: new InputDecoration(labelText: "Latitude"),
                //   onChanged: (text) {
                //     setState(() {
                //       order.latitude = double.parse(text);
                //     });
                //   },
                // ),
                // new TextField(
                //   keyboardType: TextInputType.number,
                //   autofocus: true,
                //   decoration: new InputDecoration(labelText: "Longitude"),
                //   onChanged: (text) {
                //     setState(() {
                //       order.longitude = double.parse(text);
                //     });
                //   },
                // ),
                new TextField( 
                  controller: txt,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  autofocus: true,
                  decoration: new InputDecoration(labelText: "Alamat"),
                  onChanged: (text) {
                    setState(() {
                      order.address = text;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );
  Widget choicePetshop() {
    List<String> listNamaPetshop = new List();
    listPetshop.add(Petshop("Pilih petshop"));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Pilih Petshop",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                child: new DropdownButton<Petshop>(
                  // value: order.petshop == null?Petshop("Pilih petshop"):order.petshop,
                  items: listPetshop.map((Petshop value) {
                    return new DropdownMenuItem<Petshop>(
                      value: value,
                      child: new Text(value.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      order.petshop = value;
                      idPetshop = value.id;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget choiceService() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Pilih Service ${order.petshop.name.toLowerCase()}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              showExpansionTile("Grooming"),
              showExpansionTile("Klinik"),
              showExpansionTile("Hotel")
            ],
          ),
        ),
      ),
    );
  }

  Widget showExpansionTile(String title) => FutureBuilder<List<dynamic>>(
        future: title == "Grooming"
            ? ProductController(context)
                .getDataGrooming('/petshop/${order.petshop.id}')
            : title == "Klinik"
                ? ProductController(context)
                    .getDataClinic('/petshop/${order.petshop.id}')
                : ProductController(context)
                    .getDataHotel('/petshop/${order.petshop.id}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> listDataWidget = new List();
            List<dynamic> listSnapshotData = new List();
            listSnapshotData = snapshot.data;
            for (var item in listSnapshotData) {
              listDataWidget.add(new ListTile(
                leading: Container(
                  width: 30.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(hintText: "0"),
                    onChanged: (text) {
                      var data = listGroomings
                          .where((test) => test.service.id == item.id);
                      data.length > 0
                          ? print(data.iterator.toString())
                          : listGroomings
                              .add(DetailTransaksi(item, int.parse(text)));
                    },
                  ),
                ),
                title: Text(item.name),
                subtitle: Text("Deskripsi : ${item.description}"),
                trailing: Text("${formatCurrency.format(item.price)}"),
              ));
            }
            return ExpansionTile(
              title: Text(title),
              children: listDataWidget,
            );
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      );

  Widget noteCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Note",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                new TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  autofocus: true,
                  decoration: new InputDecoration(labelText: "Note"),
                  onChanged: (text) {
                    setState(() {
                      order.note = text;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );

  Widget orderWidget() {
    deviceSize = MediaQuery.of(mcontext).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: deviceSize.height / 8,
          ),
          locationCard(),
          choicePetshop(),
          order.petshop != null ? choiceService() : Container(),
          noteCard()
        ],
      ),
    );
  }

  Widget bodyData() => new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
          ),
          orderWidget()
        ],
      );

  void tampilDialog(String tittle, String message) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (tittle == "Failed") {
                  Navigator.of(context).pop();
                } else if (tittle == "Success") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.mcontext = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.black,
        title: Text("Order"),
      ),
      body: new FutureBuilder<List<Petshop>>(
        future: PetshopController().getDataPetshop(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            listPetshop = snapshot.data;
            return bodyData();
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RaisedButton(
              child: Text("Pesan"),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                ProductController(context).sendOrder(order, idPetshop);
              },
            ),
    );
  }
}
