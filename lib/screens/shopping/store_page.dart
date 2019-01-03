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

  //stack1
  Widget imageStack(String img) => Image.network(
        img,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(Product product) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text('${formatCurrency.format(int.parse(product.price))}',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(double rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget productGrid(List<Product> products) => GridView.count(
        crossAxisCount:
            MediaQuery.of(_context).orientation == Orientation.portrait ? 2 : 3,
        shrinkWrap: true,
        children: products
            .map((product) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () => productDetail(product),
                    // onDoubleTap: () => showSnackBar(),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(product.image),
                          descStack(product),
                          // ratingStack(product.rating),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  Widget bodyData() {
    ProductBloc productBloc = ProductBloc();
    return FutureBuilder(
      future: widget.valueRoute == "Grooming"
          ? ProductController(context).getDataGrooming()
          : widget.valueRoute == "Klinik"
              ? ProductController(context).getDataClinic()
              : ProductController(context).getDataHotel(),
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
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: bodyData(),
    );
  }
}
