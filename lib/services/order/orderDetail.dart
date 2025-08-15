import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/order/orderDetail.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<OrderDetailModel>? fetchOrderDetail(String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client.get(
        Uri.parse("${url}order-detail/$uuid"),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      OrderDetailModel data = OrderDetailModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future downloadInvoice(uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response = await client
          .get(Uri.parse("${url}download-invoice/$uuid"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future payNow(String? uuid, String qsp) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}order-pay-now/$uuid?$qsp'),
        headers: headers,
      );
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

  static Future claimRefund(String? uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}claim-refund/$uuid'),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      return jsonResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future changeDeliverySlotDateTime(String? uuid, data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(
          Uri.parse('${url}change-delivery-slot/$uuid'),
          headers: headers,
          body: data);
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
