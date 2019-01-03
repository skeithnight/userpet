import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:userpet/logic/bloc/product_bloc.dart';
import 'package:userpet/models/product.dart';
import 'package:userpet/screens/widgets/common_scaffold.dart';
import 'package:userpet/controllers/product_controller.dart';
import 'package:userpet/models/model/order_model.dart';
import 'detail_order_page.dart';

class ListOrderPage extends StatefulWidget {
  _ListOrderPageState createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext _context;

  final formatCurrency = new NumberFormat.simpleCurrency(name: "IDR");

  Widget bodyData() {
    ProductBloc productBloc = ProductBloc();
    return FutureBuilder(
      future: ProductController(context).getDataOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
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

  String changeDate(int milis) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milis);
    var format = new DateFormat("yMd");
    return format.format(date);
  }

  Widget listData(List<Order> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailOrderPage('detail', listData[index])));
                },
                title: Text(listData[index].petshop.name.toUpperCase()),
                subtitle: Text("Tanggal order : ${changeDate(listData[index].from)}"),
                trailing: listData[index].status == "waiting"
                    ? Icon(Icons.hourglass_empty)
                    : listData[index].status == "jemput" ||
                            listData[index].status == "antar"
                        ? Icon(Icons.directions_car)
                        : listData[index].status == "sampai-petshop"
                            ? Icon(Icons.flag)
                            : listData[index].status == "proses"
                                ? Icon(Icons.pets)
                                : listData[index].status == "selesai-petshop"
                                    ? Icon(Icons.done)
                                    : listData[index].status == "selesai"
                                        ? Icon(Icons.done_all)
                                        : null,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "List Order",
      showDrawer: false,
      showFAB: false,
      actionApp: false,
      bodyData: bodyData(),
    );
  }
}
