import 'dart:async';

import 'package:flutter/material.dart';
import 'package:userpet/inherited/product_provider.dart';
import 'package:userpet/logic/bloc/product_bloc.dart';
import 'package:userpet/models/product.dart';
import 'package:userpet/screens/shopping/shopping_two/product_detail_widgets.dart';
import 'package:userpet/screens/widgets/login_background.dart';

class ProductDetailPage extends StatelessWidget {
  Product productData = Product();

  ProductDetailPage(Product data) {
    this.productData = data;
  }

  Widget productScaffold(Product products) => new Scaffold(
      backgroundColor: new Color(0xffeeeeee),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
          ),
          ProductDetailWidgets(product: productData),
        ],
      ));
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color(0xffeeeeee),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            LoginBackground(
              showIcon: false,
            ),
            ProductDetailWidgets(product: productData),
          ],
        ));
  }
}
