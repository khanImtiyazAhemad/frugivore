import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;

import 'package:get_storage/get_storage.dart';

import 'globals.dart' as globals;

class AuthServices {
  static final GetStorage box = GetStorage();
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future submitOtp(
      String? mobile, String otp, String devicetoken) async {
    Map<String, String> headers = await utils.getHeaders();

    try {
      final response = await client.post(Uri.parse("${url}submit-otp"),
          headers: headers,
          body: json.encode({
            "mobile": mobile, 
            "otp": otp,
            "devicetoken": devicetoken
          }));
      final auth = json.decode(response.body);
      if (response.statusCode == 200) {
        return auth;
      } else if (response.statusCode == 400) {
        return auth;
      } else {
        throw Exception(auth['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> setToken(String token) async {
    await box.write('token', token);
  }

  static Future getToken() async {
    return await box.read('token');
  }

  static Future<void> removeToken() async {
    await box.remove('token');
  }

  static Future resendOtp(String uuid) async {
    try {
      final response = await client.get(Uri.parse("${url}resend-otp/$uuid"));
      final auth = json.decode(response.body);
      if (response.statusCode == 200) {
        return auth;
      } else if (response.statusCode == 400) {
        return auth;
      } else {
        throw Exception(auth['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
