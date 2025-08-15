import 'dart:core';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/orderReview.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<OrderReviewModel>? fetchOrderReviewDetail() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}order-review"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        OrderReviewModel detail = OrderReviewModel.fromJson(jsonResponse);
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
      final response = await client.post(Uri.parse("${url}order-creation"),
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

  static Future<List<DeliveryInstructionModel>>?
      fetchDeliveryInstruction() async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse("${url}delivery-instruction"),
        headers: headers,
      );
      List<DeliveryInstructionModel> list = parseDeliveryInstructionList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

    static List<DeliveryInstructionModel> parseDeliveryInstructionList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<DeliveryInstructionModel>((json) => DeliveryInstructionModel.fromJson(json))
        .toList();
  }
}
