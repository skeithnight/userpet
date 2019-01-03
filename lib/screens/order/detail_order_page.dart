import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';

import 'package:userpet/screens/widgets/common_scaffold.dart';

import 'package:userpet/data.dart' as data1;
import 'package:userpet/models/model/order_model.dart';
import 'package:userpet/screens/widgets/maps_widget.dart';
import 'package:userpet/models/model/detail_transaksi_model.dart';

class DetailOrderPage extends StatefulWidget {
  String level = "detail";
  Order _order = new Order();
  DetailOrderPage(this.level, this._order);
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {

  Order order = new Order();
  bool aa = true;
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var usernameEditingController = new TextEditingController();

  void initState() {
    super.initState();
    setState(() {
      order = widget._order;
      nameEditingController.text = widget._order.customer.name;
    });
  }

  Widget orderContent() => Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(
                order.customer.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              )),
              ListTile(
                title: Text("Alamat"),
                subtitle: Text(order.address),
              ),
              ListTile(
                title: Text("Note"),
                subtitle: Text(order.note),
              ),
              ListTile(
                title: Text("Kurir"),
                subtitle: order.courier == null
                    ? Text("Belum di jemput")
                    : Text(order.courier.name),
              ),
              order.groomings != null
                  ? showExpansionTile("Pesanan Grooming", order.groomings)
                  : Container(),
              order.clinics != null
                  ? showExpansionTile("Pesanan Klinik", order.clinics)
                  : Container(),
              order.hotels != null
                  ? showExpansionTile("Pesanan Hotel", order.hotels)
                  : Container(),
              ListTile(
                title: Text("Total Tagihan"),
                subtitle: Text("Rp. ${hitungTagihan(order)}"),
              ),
            ],
          ),
        ),
      );

  Widget showExpansionTile(String title, List<DetailTransaksi> listData) {
    List<Widget> listDataWidget = [];
    for (var item in listData) {
      listDataWidget.add(new ListTile(
        title: Text(item.service.name),
        subtitle: Text("Jumlah : ${item.jumlah}"),
        trailing: Text("Rp. ${item.jumlah * item.service.price}"),
      ));
    }
    return ExpansionTile(
      title: Text(title),
      children: listDataWidget,
    );
  }

  double hitungTagihan(Order order){
    double totalGrooming = 0;
    double totalClinic = 0;
    double totalHotel = 0;

    if(order.groomings != null){
      for (var item in order.groomings) {
        totalGrooming = totalGrooming + (item.jumlah * item.service.price);
      }
    }
    if(order.clinics != null){
      for (var item in order.clinics) {
        totalClinic = totalClinic + (item.jumlah * item.service.price);
      }
    }
    if(order.hotels != null){
      for (var item in order.hotels) {
        totalHotel = totalHotel + (item.jumlah * item.service.price);
      }
    }
    return totalGrooming + totalClinic + totalHotel;
  }

  Widget mapswidget() => new Container(
        padding: EdgeInsets.all(10.0),
        height: 200.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: MapsWidget(
            lat: order.latitude != null ? order.latitude : -6.934837,
            lon: order.longitude != null ? order.longitude : 107.620810,
            listMarker: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: new LatLng(
                    order.latitude != null ? order.latitude : -6.934837,
                    order.longitude != null ? order.longitude : 107.620810),
                builder: (ctx) => new Container(
                      child: Icon(Icons.place),
                    ),
              )
            ],
          ),
        ),
      );

  Widget content() => new Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    mapswidget(),
                    orderContent(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Detail Order",
      showDrawer: false,
      showFAB: false,
      actionApp: false,
      bodyData: content(),
    );
  }
}
