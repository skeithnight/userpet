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

  dynamic productData;

  ShoppingDetailsPage(data) {
    this.productData = data;
    print(this.productData.name);
  }

  Widget bodyData(productData) => new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
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
        showFAB: false,
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        floatingIcon: Icons.add_shopping_cart,
        bodyData: bodyData(productData),
        showBottomNav: true,
      ),
    );
  }
}
