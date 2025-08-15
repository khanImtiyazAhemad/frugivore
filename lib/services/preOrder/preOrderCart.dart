import 'dart:core';

import 'dart:convert';
import 'package:frugivore/auth.dart';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/preOrder/preOrderCart.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<PreOrderCartModel>? fetchCartDetail() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client
          .get(Uri.parse("${url}pre-order-cart"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT $token'
      });
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
      if (response.statusCode == 200) {
        PreOrderCartModel detail = PreOrderCartModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future emptyCart() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(Uri.parse("${url}empty-pre-order-cart"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        globals.payload['cart'] = "0";
        globals.payload.refresh();
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future cartValidation() async {
    final token = await AuthServices.getToken();

    try {
      final response = await client.get(
          Uri.parse("${url}pre-order-cart-validation"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      final jsonResponse = json.decode(response.body);
      // print("JSON Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        return jsonResponse;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
