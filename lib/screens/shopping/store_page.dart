import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:userpet/logic/bloc/product_bloc.dart';
import 'package:userpet/models/product.dart';
import 'package:userpet/screens/widgets/common_scaffold.dart';

import 'product_detail_page.dart';
import 'shopping_details_page.dart';
import 'package:userpet/controllers/product_controller.dart';

class StorePage extends StatefulWidget {
  String valueRoute;
  StorePage(this.valueRoute);
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext _context;

  final formatCurrency = new NumberFormat.simpleCurrency(name: "IDR");

  Widget bodyData() {
    ProductBloc productBloc = ProductBloc();
    return FutureBuilder(
      future: widget.valueRoute == "Grooming"
          ? ProductController(context).getDataGrooming('')
          : widget.valueRoute == "Klinik"
              ? ProductController(context).getDataClinic('')
              : ProductController(context).getDataHotel(''),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listData(snapshot.data);
        } else if (snapshot.hasError) {
          // throw(snapshot.error);
          return new Center(
              child: Container(
            height: 500.0,
            child: Text("${snapshot.error}"),
          ));
        }
        return new Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget listData(data) {
    List<dynamic> listData = data;
    // print(json.encode(listData[0].description).toLowerCase());
    print(listData[0].price);
    // return Container();
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () => productDetail(listData[index]),
                title: Text(listData[index].name == null
                    ? "kosong"
                    : listData[index].name),
                subtitle: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.place),
                      title: Text(listData[index].petshop.name == null
                          ? "Nama hotel kosong"
                          : listData[index].petshop.name),
                    ),
                    ListTile(
                      leading: Icon(Icons.note),
                      title: Text(listData[index].description == null
                          ? "Deskripsi kosong"
                          : listData[index].description),
                    )
                  ],
                ),
                trailing:
                    Text('${formatCurrency.format(listData[index].price)}'),
              ),
            ));
  }

  void productDetail(data) {
    Navigator.of(_context).push(
        MaterialPageRoute(builder: ((context) => ShoppingDetailsPage(data))));
  }

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Added to cart.",
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: widget.valueRoute,
      showDrawer: false,
      showFAB: true,
      floatingIcon: Icons.description,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: bodyData(),
    );
  }
}
