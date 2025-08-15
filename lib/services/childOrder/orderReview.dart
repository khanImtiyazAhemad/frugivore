import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/childOrder/orderReview.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<ChildOrderReviewModel>? fetchOrderReviewDetail(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .get(Uri.parse("${url}child-order-review/$uuid"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        ChildOrderReviewModel detail =
            ChildOrderReviewModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future orderCreation(uuid, data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(
          Uri.parse("${url}child-order-creation/$uuid"),
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
