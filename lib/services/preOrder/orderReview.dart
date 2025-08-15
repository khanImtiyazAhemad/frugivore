import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/preOrder/orderReview.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<PreOrderReviewModel>? fetchOrderReviewDetail() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse("${url}pre-order-review"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        PreOrderReviewModel detail = PreOrderReviewModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future orderCreation(data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(Uri.parse("${url}pre-order-creation"),
          headers: headers, body: json.encode(data));
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future addressChange(data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(
          Uri.parse("${url}order-review-address-change"),
          headers: headers,
          body: json.encode(data));
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
