import 'dart:core';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/auth.dart';
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/successfull.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<SuccessfullDetailModel>? fetchSuccessfullOrderDetail(
      String uuid) async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
          Uri.parse("${url}successful-order-placed/$uuid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return SuccessfullDetailModel.fromJson(jsonResponse);
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      if (e.toString() == "Token Value null") {
        Navigator.pushNamed(Get.context!, '/login');
      }
      throw Exception(e.toString());
    }
  }
}
