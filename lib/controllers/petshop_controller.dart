import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:userpet/data.dart' as data1;
import 'package:userpet/models/model/petshop_model.dart';
import 'package:userpet/screens/widgets/dialog_widget.dart';
import 'package:userpet/screens/main_screen.dart';

class PetshopController {
  SharedPreferences prefs;
  BuildContext context;
  PetshopController();
  Dio dio = new Dio();
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // Get Data
  Future<List<Petshop>> getDataPetshop() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlPetshop;

    var response = await dio.get('');
    List<dynamic> map = response.data;
    List<Petshop> listPetshop = new List();
    for (var i = 0; i < map.length; i++) {
      listPetshop.add(Petshop.fromSnapshot(map[i]));
    }
    return listPetshop;
  }
}