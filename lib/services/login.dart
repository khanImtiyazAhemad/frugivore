import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/login.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<OtpModel> getOtp(data) async {
    try {
      final response =
          await client.post(Uri.parse("${url}get-otp"), body: data);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        OtpModel loginDetail = OtpModel.fromJson(jsonResponse);
        return loginDetail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<LoginBannerModel> loginBanner() async {
    try {
      final response = await client.post(Uri.parse("${url}login-banner"), body: {});
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        LoginBannerModel loginDetail = LoginBannerModel.fromJson(jsonResponse);
        return loginDetail;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
