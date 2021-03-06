class Customer {
  String id;
  String username;
  String password;
  String name;

  Customer();

  Customer.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        username = snapshot["username"],
        name = snapshot["name"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        // "enabled": enabled,
      };
  Map<String, dynamic> toJsonRegister() => {
        "username": username,
        "password": password,
        "name": name,
        "enabled": true,
      };
  Map<String, dynamic> toJsonLogin() => {
        "username": username,
        "password": password,
      };
}
