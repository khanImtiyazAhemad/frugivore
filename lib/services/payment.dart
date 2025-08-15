import 'dart:core';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/payment.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<PaymentModel>? fetchPaymentDetails(String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}payment/$uuid"), headers: headers);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        PaymentModel detail = PaymentModel.fromJson(jsonResponse);
        return detail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future razorpayOrder(data) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(
          Uri.parse('${url}razorpay-order-creation'),
          headers: headers,
          body: data);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      return jsonResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future placedWalletOrder(String uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}wallet-place-order/$uuid'),
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

  static Future onlinePayment(String? uuid, String qsp) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}payment-gateway/successfull-payment/$uuid?$qsp'),
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

  static Future removeOrder(String? uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}remove-order/$uuid'),
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

  static Future repeatOrderReview(String? uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}repeat-order-review/$uuid'),
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

  static Future appliedDiscountCode(String uuid, String promocode) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}discount-applied/$uuid/$promocode'),
        headers: headers,
      );
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
}
