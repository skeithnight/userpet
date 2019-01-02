import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:userpet/data.dart' as data;
import 'package:userpet/models/model/customer_model.dart';
import 'package:userpet/screens/widgets/dialog_widget.dart';
import 'package:userpet/screens/login/login_two_page.dart';
import 'package:userpet/screens/login/sign_up_page.dart';

class RegisterController {
  BuildContext context;
  RegisterController(this.context);
  Dio dio = new Dio();
  Customer customer = new Customer();
  void sendData(Customer _customer) async {
    customer = _customer;

    if (checkData() && checkData() != null) {
      try {
        print(customer.toJsonRegister());
        var response =
            await dio.post(data.urlRegister, data: customer.toJsonRegister());
        // If server returns an OK response, parse the JSON
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Success", "Success to save data..", LoginTwoPage());
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Failed", "Server data error", () {});
      }
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  bool checkData() {
    bool result = false;
    if (customer != null) {
      if (customer.username != null ||
          customer.name != null ||
          customer.password != null) {
        result = true;
      }
    }
    return result;
  }
}
