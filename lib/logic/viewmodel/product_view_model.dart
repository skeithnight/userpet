import 'package:flutter/material.dart';
import 'package:userpet/models/product.dart';

class ProductViewModel {
  
  List<Product> productsItems;

  ProductViewModel({this.productsItems});

  getProducts() => <Product>[
        Product(
            brand: "Royal Canin",
            description: "Royal Canin Persian Kitten dry food for growing Persian cats, with exclusive nutrient formula to reduce undigested food and FOS for a balanced intestinal flora.",
            image:
                "https://shop-cdn-m.shpp.ext.zooplus.io/bilder/royal/canin/persian/kitten/2/400/la_pla_royalcanin_kitten_pe_2.jpg",
            name: "Royal Canin Persian Kitten",
            price: "60000",
            rating: 4.5,
            quantity: 0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
            ],
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 0),
      ];
}
