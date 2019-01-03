import 'petshop_model.dart';

class Service {
  String idPetshop;
  String id;
  Petshop petshop;
  String name;
  String description;
  List<String> pictures;
  double price;

  Service();
  

  Service.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    id = snapshot["id"];
    petshop = Petshop.fromSnapshot(snapshot["petshop"]);
    name = snapshot["name"];
    description = snapshot["descrition"];
    pictures = snapshot["pictures"];
    price = snapshot["price"];
  }

  Map<String, dynamic> toJsonInsert() => {
        "petshop": {
          "id": idPetshop,
        },
        "name": name,
        "descrition": description,
        // "pictures": address,
        "price": price,
      };
}
