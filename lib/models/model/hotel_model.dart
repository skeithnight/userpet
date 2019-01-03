import 'petshop_model.dart';
import 'service_model.dart';

class Hotel extends Service{

  Hotel();

  Hotel.fromSnapshot(Map<dynamic, dynamic> snapshot){
    id = snapshot["id"];
    petshop = Petshop.fromSnapshot(snapshot["petshop"]);
    name = snapshot["name"];
    description = snapshot["description"];
    pictures = snapshot["pictures"];
    price = snapshot["price"];
  }
}
