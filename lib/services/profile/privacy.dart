import 'dart:core';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frugivore/utils.dart' as utils;
import 'package:frugivore/globals.dart' as globals;

import 'package:frugivore/models/profile/privacy.dart';

class Services {
  static var client = http.Client();

  static const String url = globals.baseuri + globals.backenduri;

  static Future<PrivacyModel>? fetchPrivacyDetail() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}privacy-detail"), headers: headers);
      final jsonResponse = json.decode(response.body);
      // print("Response $jsonResponse");
      if (response.statusCode == 200) {
        PrivacyModel data = PrivacyModel.fromJson(jsonResponse);
        return data;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future updateProfile(Map? data) async {
    Map<String, String>? headers = await utils.getHeaders();
    try {
      final response = await client.post(Uri.parse("${url}profile"),headers: headers, body: json.encode(data));
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

    static Future deleteAccount() async {
    Map<String, String>? headers = await utils.getHeaders();

    try {
      final response =
          await client.get(Uri.parse("${url}delete-my-account"), headers: headers);
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
