import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/orderOtp.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<OrderOtpModel>? fetchOTP(String? uuid) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.get(
        Uri.parse('${url}order-otp/$uuid'),
        headers: headers,
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        OrderOtpModel data = OrderOtpModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future submitOtp(String? uuid, otp, wallet) async {
    Map<String, String>? headers = await utils.postHeaders();
    try {
      final response = await client.post(
          Uri.parse('${url}order-otp-verification/$uuid?wallet=$wallet'),
          headers: headers,
          body: {"otp": otp});
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      return jsonResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future removeOrder(String uuid) async {
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
}
