import 'dart:core';

import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/preOrder/preOrder.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<PreOrderModel>? fetchPreOrder() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client
          .get(Uri.parse("${url}pre-order"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT $token'
      });
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
      if (response.statusCode == 200) {
        PreOrderModel detail = PreOrderModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
