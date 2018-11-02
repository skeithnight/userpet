import 'package:flutter/material.dart';
import 'package:userpet/models/product.dart';

class ProductViewModel {
  
  List<Product> productsItems;

  ProductViewModel({this.productsItems});

  getProducts() => <Product>[
        Product(
            brand: "Levis",
            description: "Print T-shirt",
            image:
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
            name: "THE PERFECT",
            price: "1999",
            rating: 4.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170),
        Product(
            brand: "adidas Performance",
            description: "Pool sliders",
            image:
                "https://mosaic02.ztat.net/vgs/media/catalog-lg/AD/58/1D/00/9Q/12/AD581D009-Q12@13.jpg",
            name: "AQUALETTE",
            price: "1349",
            rating: 5.0,
            totalReviews: 10),
        Product(
            brand: "Royal Canin",
            description: "Royal Canin Persian Kitten dry food for growing Persian cats, with exclusive nutrient formula to reduce undigested food and FOS for a balanced intestinal flora.",
            image:
                "https://shop-cdn-m.shpp.ext.zooplus.io/bilder/royal/canin/persian/kitten/2/400/la_pla_royalcanin_kitten_pe_2.jpg",
            name: "Royal Canin Persian Kitten",
            price: "60000",
            rating: 4.5,
            totalReviews: 0),
      ];
}
