import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:userpet/data.dart' as data1;
import 'package:userpet/models/model/petshop_model.dart';
import 'package:userpet/screens/widgets/dialog_widget.dart';
import 'package:userpet/screens/main_screen.dart';

class CourierController {
  SharedPreferences prefs;
  BuildContext context;
  CourierController(this.context);
  Dio dio = new Dio();
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // Get Data
  Future<List<Petshop>> getData() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlCourier;

    var response = await dio.get(data1.pathCourierPetshop);
    List<dynamic> map = response.data;
    List<Petshop> listPetshop = new List();
    for (var i = 0; i < map.length; i++) {
      listPetshop.add(Petshop.fromSnapshot(map[i]));
    }
    return listPetshop;
  }
}