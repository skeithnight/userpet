import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:userpet/models/product.dart';
import 'package:userpet/screens/shopping/shopping_details/shopping_action.dart';
import 'package:userpet/screens/widgets/label_icon.dart';
import 'package:userpet/screens/widgets/maps_widget.dart';

class ShoppingWidgets extends StatelessWidget {
  Size deviceSize;
  final dynamic product;

  final formatCurrency = new NumberFormat.simpleCurrency(name: "IDR");

  ShoppingWidgets({Key key, this.product}) : super(key: key);
  Widget mainCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.name == null ? "Deskripsi kosong" : product.name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: Text(
                    '${formatCurrency.format(product.price)}',
                    style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget petshopCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Petshop",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.petshop.name == null
                      ? "Nama petshop kosong"
                      : product.petshop.name,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.petshop.address == null
                      ? "Alamat petshop kosong"
                      : product.petshop.address,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 100.0,
                  child: MapsWidget(
                    lat: product.petshop.latitude != null
                        ? product.petshop.latitude
                        : -6.934837,
                    lon: product.petshop.longitude != null
                        ? product.petshop.longitude
                        : 107.620810,
                    listMarker: [
                      new Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new LatLng(
                            product.petshop.latitude != null
                                ? product.petshop.latitude
                                : -6.934837,
                            product.petshop.longitude != null
                                ? product.petshop.longitude
                                : 107.620810),
                        builder: (ctx) => new Container(
                              child: Icon(Icons.place),
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
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
                  "Description",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  product.description == null
                      ? "Deskripsi kosong"
                      : product.description,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: deviceSize.height / 8,
          ),
          mainCard(),
          descCard(),
          petshopCard(),
        ],
      ),
    );
  }
}
