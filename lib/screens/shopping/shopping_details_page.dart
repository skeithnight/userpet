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

  Widget bodyData(Stream<List<Product>> products) =>
      StreamBuilder<List<Product>>(
          stream: products,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoginBackground(
                        showIcon: false,
                        image: snapshot.data[0].image,
                      ),
                      ShoppingWidgets(product: snapshot.data[0]),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          });

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
        bodyData: bodyData(productBloc.productItems),
        showBottomNav: true,
      ),
    );
  }
}
