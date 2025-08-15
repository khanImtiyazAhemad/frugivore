import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/cart.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<CartModel>? fetchCartDetail() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}cart"), headers: headers);
      final jsonResponse = json.decode(response.body);
      globals.payload['cart'] = jsonResponse['count'].toString();
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        CartModel detail = CartModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<CartModel> fetchNonLoggedInCartDetail(data) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.post(Uri.parse("${url}non-logged-in-cart"),
          headers: headers, body: json.encode(data));
      final jsonResponse = json.decode(response.body);
      globals.payload['cart'] = jsonResponse['count'].toString();
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        CartModel detail = CartModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future emptyCart() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}empty-cart"), headers: headers);
      final jsonResponse = json.decode(response.body);
      globals.payload['cart'] = "0";
      globals.payload.refresh();
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future cartValidation() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(Uri.parse("${url}cart-validation"),
          headers: headers);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 400) {
        return jsonResponse;
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
