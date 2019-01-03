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
import 'package:userpet/models/model/order_model.dart';
import 'package:userpet/screens/main_screen.dart';
import 'package:userpet/models/model/detail_transaksi_model.dart';

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
  Future<List<Order>> getDataOrder() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlOrder;

    try {
      var response = await dio.get('/customer/${prefs.getString('idCustomer')}');
      List<dynamic> map = response.data;
    // print(map[0]['groomings']);
    List<Order> listOrder = new List();
    List<DetailTransaksi> listGroomings = new List();
    List<DetailTransaksi> listClinics = new List();
    List<DetailTransaksi> listHotels = new List();
    for (var i = 0; i < map.length; i++) {
      if (map[i]['groomings'] != null) {
        for (var j = 0; j < map[i]['groomings'].length; j++) {
          listGroomings
              .add(DetailTransaksi.fromSnapshot(map[i]['groomings'][j]));
        }
      } else {
        listGroomings = null;
      }
      if (map[i]['clinics'] != null) {
        for (var j = 0; j < map[i]['clinics'].length; j++) {
          listClinics.add(DetailTransaksi.fromSnapshot(map[i]['clinics'][j]));
        }
      } else {
        listClinics = null;
      }
      if (map[i]['hotels'] != null) {
        for (var j = 0; j < map[i]['hotels'].length; j++) {
          listHotels.add(DetailTransaksi.fromSnapshot(map[i]['hotels'][j]));
        }
      } else {
        listHotels = null;
      }
      listOrder.add(
          Order.fromSnapshot(map[i], listGroomings, listClinics, listHotels));
    }
    return listOrder;
    } on DioError catch (e) {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
      return null;
    }
  }

  // Grooming
  Future<List<Grooming>> getDataGrooming(String path) async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlGrooming;

    try {
      var response = await dio.get(path);
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
  Future<List<Clinic>> getDataClinic(String path) async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlClinic;

    try {
      var response = await dio.get(path);
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
  Future<List<Hotel>> getDataHotel(String path) async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlHotel;

    try {
      var response = await dio.get(path);
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

  void sendOrder(Order order, String idPetshop) async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlOrder;

    try {
      print(order.toJsonDataPesan(
          prefs.getString('idCustomer'), idPetshop, null, null, null));
      var response = await dio.post('',
          data: order.toJsonDataPesan(
              prefs.getString('idCustomer'), idPetshop, null, null, null));

      print(response.statusCode);
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Success", "Success saving data", MainScreen());
    } on DioError catch (e) {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
      return null;
    }
  }
}
