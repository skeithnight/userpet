import 'dart:async';

import 'package:flutter/material.dart';
import 'package:userpet/inherited/product_provider.dart';
import 'package:userpet/logic/bloc/product_bloc.dart';
import 'package:userpet/models/product.dart';
import 'package:userpet/screens/shopping/shopping_details/shopping_widget.dart';
import 'package:userpet/screens/widgets/common_scaffold.dart';
import 'package:userpet/screens/widgets/login_background.dart';

class ShoppingDetailsPage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  Product productData = Product();

  ShoppingDetailsPage(Product data) {
    this.productData = data;
  }

  // Widget bodyData(Product products) => StreamBuilder<Product>(
  //     builder: (context, snapshot) {
  //       return snapshot.hasData
  //           ? Stack(
  //               fit: StackFit.expand,
  //               children: <Widget>[
  //                 LoginBackground(
  //                   showIcon: false,
  //                   image: snapshot.data.image,
  //                 ),
  //                 ShoppingWidgets(product: snapshot.data),
  //               ],
  //             )
  //           : Center(child: CircularProgressIndicator());
  //     });

  Widget bodyData(Product productData) => new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
            image: productData.image,
          ),
          ShoppingWidgets(product: productData),
        ],
      );

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
    return ProductProvider(
      productBloc: productBloc,
      child: CommonScaffold(
        backGroundColor: Colors.grey.shade100,
        actionFirstIcon: null,
        appTitle: "Product Detail",
        showFAB: true,
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        centerDocked: true,
        floatingIcon: Icons.add_shopping_cart,
        bodyData: bodyData(productData),
        showBottomNav: true,
      ),
    );
  }
}
