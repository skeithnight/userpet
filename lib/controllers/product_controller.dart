import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:userpet/data.dart' as data1;
import 'package:userpet/models/model/grooming_model.dart';
import 'package:userpet/models/model/clinic_model.dart';
import 'package:userpet/models/model/hotel_model.dart';
import 'package:userpet/screens/widgets/dialog_widget.dart';

class ProductController {
  SharedPreferences prefs;
  BuildContext context;
  ProductController(this.context);
  Dio dio = new Dio();

  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // Grooming
  Future<List<Grooming>> getDataGrooming() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlGrooming;

    try {
      var response = await dio.get('');
      List<dynamic> map = response.data;
      List<Grooming> listgrooming = new List();
      for (var i = 0; i < map.length; i++) {
        listgrooming.add(Grooming.fromSnapshot(map[i]));
      }
      return listgrooming;
    } on DioError catch (e) {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
      return null;
    }
  }
  // Clinic
  Future<List<Clinic>> getDataClinic() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlClinic;

    try {
      var response = await dio.get('');
      List<dynamic> map = response.data;
      List<Clinic> listclinic = new List();
      for (var i = 0; i < map.length; i++) {
        listclinic.add(Clinic.fromSnapshot(map[i]));
      }
      // print(listgrooming[0].name);
      return listclinic;
    } on DioError catch (e) {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
      return null;
    }
  }
  // Hotel
  Future<List<Hotel>> getDataHotel() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlHotel;

    try {
      var response = await dio.get('');
      List<dynamic> map = response.data;
      List<Hotel> listhotel = new List();
      for (var i = 0; i < map.length; i++) {
        listhotel.add(Hotel.fromSnapshot(map[i]));
      }
      // print(listgrooming[0].name);
      return listhotel;
    } on DioError catch (e) {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
      return null;
    }
  }
}
